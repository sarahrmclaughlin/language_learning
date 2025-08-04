import os

import yaml

yaml_path = "configs.words_for_animals.yaml"
if not os.path.exists(yaml_path):
    raise FileNotFoundError(f"YAML file not found: {yaml_path}")

with open(yaml_path, "r") as language_config:
    languages = yaml.load(language_config, Loader=yaml.FullLoader)
    if not isinstance(languages, dict) or "retrieve_words" not in languages:
        raise KeyError("'retrieve_words' key not found in YAML file")

retrieve_words = languages["retrieve_words"]

retrieve_words

print("Retrieve words configuration loaded successfully.")
