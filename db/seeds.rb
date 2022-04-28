config = YAML.load_file('spec/support/categories.yml').freeze

config.each do |key, _value|
  Category.create(title: key['title'], image: key['image'], transaction_type: key['transaction_type'])
end
