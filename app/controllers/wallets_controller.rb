class WalletsController < ApplicationController
  before_action :authenticate_user!

  def create
    @wallet = Wallet.new(wallet_params)
    if @wallet.save
      redirect_to dashboards_path
    else
      render :new
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
    params.permit(:name, :currency, :quantity, :user_id)
  end
end
