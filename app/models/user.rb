class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wallets, dependent: :destroy
  has_many :categories, dependent: :destroy
end
