class WalletsController < ApplicationController
  before_action :authenticate_user!

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
end
