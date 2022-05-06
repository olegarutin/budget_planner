class ReportsController < ApplicationController
  def index
    @expense_by_days = Wallet.date_range(created_at.day, Date.today).quantity
  end
end
