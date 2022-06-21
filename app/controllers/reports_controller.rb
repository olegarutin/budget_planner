class ReportsController < ApplicationController
  def index
    @transaction_type = params[:transaction_type] || 'expense'
    @start_date = params[:start_date] || 7.days.ago.to_date.to_s
    @end_date = params[:end_date] || Date.tomorrow.to_date.to_s
  end
end
