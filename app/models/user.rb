class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  PASSWORD_ERROR_MESSAGE = 'must be between 6 and 18 characters,
    must contain letters in mixed case, must contain numbers'.freeze

  validates :password, format: {
    with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{6,18}\z/,
    message: PASSWORD_ERROR_MESSAGE
  }

  has_many :wallets, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :webpush_subscriptions, dependent: :destroy

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end
end
