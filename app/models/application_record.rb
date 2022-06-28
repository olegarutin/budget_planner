class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  QUANTITY_VALIDATION_ERROR = 'must be less than or equal to 1000000000'.freeze
end
