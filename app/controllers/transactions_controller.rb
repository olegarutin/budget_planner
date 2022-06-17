class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: :destroy
  before_action :set_categories, only: %i[new create]
  before_action :set_category, only: :create

  def index
    @transactions = current_user.transactions.includes(:category).sort_by(&:created_at)

    @transactions.where!('note ILIKE ?', "%#{params[:query]}%").load_async if params[:query].present?
    @transactions.where!(category_id: params[:category]).load_async if params[:category].present?
    @transactions.where!(created_at: params[:day].to_i.day.ago..Time.now).load_async if params[:day].present?
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    respond_to do |format|
      if @transaction.save
        format.turbo_stream { render :create }
      else
        format.turbo_stream { render :create, status: :found }
      end
    end
  end

  def destroy
    @transaction.destroy
  end

  private

  def transaction_params
    params.permit(:amount, :note, :wallet_id, :category_id).merge(
      user: current_user, transaction_type: @category.transaction_type
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
