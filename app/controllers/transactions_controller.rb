class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: :destroy
  before_action :set_category, only: :create

  def index
    @transactions = current_user.transactions.includes(:category)

    @transactions.where!('note ILIKE ?', "%#{params[:query]}%") if params[:query].present?
    @transactions.where!(category_id: params[:category]) if params[:category].present?
    @transactions.where!(created_at: params[:day].to_i.day.ago..Time.now) if params[:day].present?
  end

  def create
    @categories = Category.all.where(user: [current_user, nil])
    @transaction = Transaction.new(transaction_params
      .merge(user: current_user, transaction_type: @category.transaction_type))
    respond_to do |format|
      if @transaction.save
        format.turbo_stream { render :create }
        WalletUpdater.call(
          amount: params[:amount],
          transaction: @transaction,
          transaction_type: @category.transaction_type
        )
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.replace(
              ActionView::RecordIdentifier.dom_id(@transaction.wallet),
              partial: 'wallets/wallet',
              locals: { wallet: @transaction.wallet }
            )
        end
      else
        format.turbo_stream { render :create, status: :found }
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
    params.permit(:amount, :note, :wallet_id, :category_id)
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end
end
