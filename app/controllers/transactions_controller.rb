class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: :destroy

  def index
    @transactions = current_user.transactions
    return unless params[:query]

    @transactions = @transactions.where('note ILIKE ?', "%#{params[:query]}%")
  end

  def create
    @transaction = Transaction.new(transaction_params.merge(user: current_user))
    WalletUpdater.call(
      amount: params[:amount],
      transaction: @transaction,
      transaction_type: params[:transaction_type]
    )
    respond_to do |format|
      if @transaction.save
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.replace(
              ActionView::RecordIdentifier.dom_id(@transaction.wallet),
              partial: 'wallets/wallet',
              locals: { wallet: @transaction.wallet }
            )
        end
      else
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.before(
              'transactions',
              partial: 'shared/error_messages',
              locals: { transaction: @transaction }
            )
        end
      end
    end
  end

  def update
    @transaction.update(transaction_params)
  end

  def destroy
    @transaction.destroy
  end

  private

  def transaction_params
    params.permit(:amount, :note, :transaction_type, :wallet_id, :category_id)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end
end
