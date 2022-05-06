class WalletUpdater < BaseService
  attr_accessor :amount, :transaction, :transaction_type

  def initialize(amount:, transaction:, transaction_type:)
    @amount = amount
    @transaction = transaction
    @transaction_type = transaction_type
  end

  def call
    transaction.wallet.update!(quantity: calculated_quantity)
  end

  private

  def calculated_quantity
    if transaction_type.to_sym == Transaction::INCOME_TYPE
      quantity.to_i + amount.to_i
    else
      quantity.to_i - amount.to_i
    end
  end

  def quantity
    transaction.wallet.quantity
  end
end
