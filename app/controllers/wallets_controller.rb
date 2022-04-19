class WalletsController < ApplicationController
  before_action :authenticate_user!

  def create
    @wallet = Wallet.create(wallet_params)
    redirect_to root_path
  end

  def update
    @wallet.update(wallet_params)
  end

  def destroy
    @wallet.destroy
  end

  private

  def wallet_params
    params.permit(:name, :currency, :quantity, :user_id)
  end
end
