class TransactionsController < ApplicationController
  before_action :set_transaction, only: :destroy
  before_action :set_categories, only: %i[new create]
  before_action :set_category, only: :create
  after_action -> { flash.clear }

  def index
    @transactions = TransactionsSorter.call(transactions: current_user.transactions, params: params)

    @pagy, @transactions = pagy(@transactions)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      update_wallet(@category.transaction_type)

      flash.notice = 'Transaction successfully created'
    else
      render :create, status: :found
    end
  end

  def destroy
    @transaction.destroy
    update_wallet(@transaction.reverse_type)

    flash.notice = 'Transaction successfully destroyed'
  end

  private

  def transaction_params
    params.
      permit(:note, :wallet_id, :category_id).
      merge(
        user: current_user,
        transaction_type: @category.transaction_type,
        amount: amount_to_number_format(params[:amount])
      )
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_categories
    @categories = Category.all.where(user: [current_user, nil])
  end

  def update_wallet(transaction_type)
    WalletUpdater.call(
      amount: @transaction.amount,
      transaction: @transaction,
      transaction_type: transaction_type
    )
  end
end
