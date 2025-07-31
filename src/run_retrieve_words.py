import yaml 

with open('config.yaml', 'r') as language_config:
    languages  = yaml.load(language_config, Loader=yaml.FullLoader)

retrieve_words = languages['retrieve_words']