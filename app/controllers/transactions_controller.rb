class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = Transaction.all
  end

  def new
    redirect_to new_wallet_path if current_user.wallets.empty?
  end

  def create
    @transaction = Transaction.create(transaction_params)

    WalletUpdater.call(
      amount: params[:amount],
      transaction: @transaction,
      transaction_type: params[:transaction_type]
    )

    if @transaction.save
      redirect_to page_path('dashboard')
    else
      render :new
    end
  end

  def update
    @transaction.update(transaction_params)
  end

  private

  def transaction_params
    params.permit(:amount, :note, :transaction_type, :wallet_id, :category_id, :user_id)
  end
end
