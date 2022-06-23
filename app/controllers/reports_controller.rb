class ReportsController < ApplicationController
  def index
    @user_wallet = params[:user_wallet] || current_user.wallets.first
    @transaction_type = params[:transaction_type] || 'expense'
    @start_date = params[:start_date] || 7.days.ago.to_date.to_s
    @end_date = params[:end_date] || Date.tomorrow.to_date.to_s
  end
end
