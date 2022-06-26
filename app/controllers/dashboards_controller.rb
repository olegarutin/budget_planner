class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_resources, only: :index

  def index
    @pagy, @transactions = pagy(@transactions)
    return unless @wallets.present?

    @wallets.each do |wallet|
      if wallet.quantity.negative?
        PlannerNotification.with(planner: "You've already reached the limit of #{wallet.name}").deliver(current_user)
      end
    end
  end

  private

  def load_resources
    @categories = Category.all.where(user: [current_user, nil])
    @transactions = current_user.transactions.order(created_at: :desc)
    @wallets = current_user.wallets.order(created_at: :desc)
  end
end
