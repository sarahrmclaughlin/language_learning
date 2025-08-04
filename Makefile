PYTHON = python3
PIP = pip3

install-dev:
	$(PIP) install -r requirements.txt
	$(PIP) install black isort flake8 pylint

format:
	black .
	isort .
lint:
	flake8 src/ --max-line-length=88
	flake8 eda_notebook.ipynb --max-line-length=88
	pylint *.py