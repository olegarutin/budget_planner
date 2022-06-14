class WalletsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wallets, only: :create

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

  def update
    @wallet.update(wallet_params)
  end

  def destroy
    @wallet.destroy
  end

  private

  def wallet_params
    params.permit(:name, :currency, :quantity).merge(user: current_user)
  end

  def set_wallets
    @wallets = current_user.wallets
  end
end
