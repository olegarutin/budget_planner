class Category < ApplicationRecord
  validates :title, presence: true

  enum kind: %i[regular irregular]
end
