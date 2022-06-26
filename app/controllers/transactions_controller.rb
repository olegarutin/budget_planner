class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: :destroy
  before_action :set_categories, only: %i[new create]
  before_action :set_category, only: %i[create]

  def index
    if params[:wallet_id].present?
      @wallet = Wallet.find(params[:wallet_id])
      @transactions = @wallet.transactions.includes(:category).order(created_at: :desc).load_async
    else
      @transactions = current_user.transactions.includes(:category).order(created_at: :desc).load_async
    end

    if params[:start_date].present?
      @transactions = @transactions.where(
        created_at: params[:start_date].to_date.beginning_of_day..params[:end_date].to_date.end_of_day
      )
    end
    if params[:type].present?
      @transactions = @transactions.send(params[:type])
    end
    if params[:query].present?
      @transactions = @transactions.where('note ILIKE ?', "%#{params[:query]}%")
    end
    if params[:category].present?
      @transactions = @transactions.where(category_id: params[:category])
    end

    @pagy, @transactions = pagy(@transactions)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      WalletUpdater.call(
        amount: @transaction.amount,
        transaction: @transaction,
        transaction_type: @category.transaction_type
      )
    else
      render :create, status: :found
    end
  end

  def destroy
    @transaction.destroy
    WalletUpdater.call(
      amount: @transaction.amount,
      transaction: @transaction,
      transaction_type: @transaction.reverse_type
    )
  end

  private

  def amount_to_number_format
    (params[:amount].gsub(',', '.').to_f * 100).to_i
  end

  def transaction_params
    params.permit(:note, :wallet_id, :category_id).merge(
      user: current_user,
      transaction_type: @category.transaction_type,
      amount: amount_to_number_format
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
end
