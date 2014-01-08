import ConfigParser
config = ConfigParser.ConfigParser()
config.read('ftr_extractor_configurations.cfg')

for section in config.sections():
    print(section)
    for option in config.options(section):
        print(option,config.get(section,option))
    
    