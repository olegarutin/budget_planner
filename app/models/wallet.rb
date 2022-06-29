class Wallet < ApplicationRecord
  UAH = { shortname: 'uah', name: 'Ukrainian Hryvnia', symbol: '₴' }.freeze
  USD = { shortname: 'usd', name: 'United States Dollar', symbol: '$' }.freeze
  PLN = { shortname: 'pln', name: 'Polish Złoty', symbol: 'zł' }.freeze
  EUR = { shortname: 'eur', name: 'Euro', symbol: '€' }.freeze

  CURRENCIES = [UAH, USD, PLN, EUR].freeze

  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }, length: { maximum: 20 }, on: :create
  validates :name, :currency, presence: true
  validates :quantity, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 1_000_000_000_00,
    message: QUANTITY_VALIDATION_ERROR
  }, on: :create

  scope :date_range, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }

  def convert_to_currency_format
    quantity / 100.to_f
  end

  def self.currencies_select_object
    CURRENCIES.map { |currency| ["#{currency[:symbol]} #{currency[:name]}", currency[:shortname]] }
  end

  def currency_symbol
    CURRENCIES.detect { |currency| currency[:shortname] == self.currency }[:symbol]
  end
end
