class TransactionsController < ApplicationController
	def index
		@transactions = Transaction.all
	end

  def create
  	@transaction = Transaction.create(transaction_params)
    if @transaction.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
  	@transaction.update(transaction_params)
  end

  private

  def transaction_params
  	params.require(:transaction).permit(:amount, :note, :transaction_type, :wallet_id, :category_id)
  end
end
