import yaml 
from pathlib import Path

def get_and_open_yaml_config(yaml_file_name: str) -> dict:
    """
    Load a YAML configuration file from the 'configs' directory.
    Args:
        yaml_file_name (str): The name of the YAML file without the '.yaml' extension.
    Returns:
        dict: The contents of the YAML file as a dictionary.
    """

    config_path = Path('configs')/f"{yaml_file_name}.yaml"

    with open(config_path, 'r') as file:
        config = yaml.safe_load(file)

    return config