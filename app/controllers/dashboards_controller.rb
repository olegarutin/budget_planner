class DashboardsController < ApplicationController
  def index
    @categories = Category.all
  end
end
