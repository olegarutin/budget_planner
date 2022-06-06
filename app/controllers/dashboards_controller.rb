class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all.where(user: [current_user, nil])
    @transactions = current_user.transactions
  end
end
