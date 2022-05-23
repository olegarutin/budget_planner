class DashboardsController < ApplicationController
  def index
    @categories = Category.all
    @transactions = current_user.transactions
  end
end
