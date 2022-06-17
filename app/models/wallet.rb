class Wallet < ApplicationRecord
  USD = { shortname: 'usd', name: 'United States Dollar', symbol: '$' }.freeze
  UAH = { shortname: 'uah', name: 'Ukrainian Hryvnia', symbol: '₴' }.freeze
  PLN = { shortname: 'pln', name: 'Polish Złoty', symbol: 'zł' }.freeze
  EUR = { shortname: 'eur', name: 'Euro', symbol: '€' }.freeze
  TRY = { shortname: 'try', name: 'Turkish Lira', symbol: '₺' }.freeze
  CNY = { shortname: 'cny', name: 'Chinese Renminbi Yuan', symbol: '元' }.freeze
  JPY = { shortname: 'jpy', name: 'Japanese Yen', symbol: '¥' }.freeze
  GBP = { shortname: 'gbp', name: 'British Pound', symbol: '£' }.freeze

  CURRENCIES = [USD, UAH, PLN, EUR, TRY, CNY, JPY, GBP].freeze

  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }, length: { maximum: 20 }, on: :create
  validates :name, :currency, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0, less_than: 1_000_000_00 }, on: :create

  scope :date_range, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }

  after_destroy_commit { broadcast_remove_to 'wallets' }

  def convert_to_currency_format
    quantity / 100.to_f
  end
end
