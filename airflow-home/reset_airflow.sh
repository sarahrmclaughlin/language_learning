#!/bin/bash
# Reset Airflow setup — for dev/testing environments only

# Set AIRFLOW_HOME to the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export AIRFLOW_HOME="$SCRIPT_DIR"

echo "📂 Using AIRFLOW_HOME: $AIRFLOW_HOME"

# Activate virtual environment if .venv exists here
if [ -d "$SCRIPT_DIR/.venv" ]; then
    echo "🐍 Activating virtual environment..."
    source "$SCRIPT_DIR/.venv/bin/activate"
else
    echo "⚠️ No .venv found in $SCRIPT_DIR — activate your venv manually."
fi

echo "🔍 Stopping all Airflow processes..."
pkill -f "airflow" 2>/dev/null

echo "🧹 Removing logs..."
rm -rf "$AIRFLOW_HOME/logs"/*

# Optional: wipe database
read -p "Do you want to reset the metadata database? (y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "🗑 Wiping database..."
    rm -f "$AIRFLOW_HOME/airflow.db"  # Only for SQLite setups
    airflow db reset -y 2>/dev/null || airflow db migrate
else
    echo "⏩ Skipping database reset..."
fi

echo "🚀 Migrating database schema..."
airflow db migrate

# Optional: create admin user (only if using FAB auth)
read -p "Do you want to create an admin user? (y/N): " create_user
if [[ "$create_user" =~ ^[Yy]$ ]]; then
    airflow users create \
      --username admin \
      --firstname Admin \
      --lastname User \
      --role Admin \
      --email admin@example.com \
      --password admin
fi

echo "▶️ Starting scheduler..."
airflow scheduler &

echo "🌐 Starting webserver..."
airflow webserver --port 8080 &

echo "✅ Airflow has been reset and restarted."
echo "🌐 Visit: http://localhost:8080"
