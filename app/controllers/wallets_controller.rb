class WalletsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wallets, only: %i[create destroy]
  before_action :set_wallet, only: :destroy

  def create
    @wallet = Wallet.new(wallet_params)

    respond_to do |format|
      if @wallet.save
        format.turbo_stream { render :create }
      else
        format.turbo_stream { render :create, status: :found }
      end
    end
  end

  def destroy
    @wallet.destroy
    @pagy, @transactions = pagy(current_user.transactions)
  end

  private

  def wallet_params
    params.permit(:name, :currency).merge(
      user: current_user,
      quantity: amount_to_number_format(params[:quantity])
    )
  end

  def set_wallets
    @wallets = current_user.wallets.order(created_at: :desc)
  end

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end
end
