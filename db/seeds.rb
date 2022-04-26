config = YAML.load_file('spec/support/seed.yml').freeze

config.each do |key, _value|
  Category.create(title: key, image: config[key]['image'], transaction_type: config[key]['transaction_type'])
end
