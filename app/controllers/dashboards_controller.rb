class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all.where(user: [current_user, nil])
    @pagy, @transactions = pagy(current_user.transactions.order(created_at: :desc))
    @wallets = current_user.wallets.order(created_at: :desc)
    return unless @wallets.present?

    @wallets.each do |wallet|
      if wallet.quantity.negative?
        PlannerNotification.with(planner: "You've already reached the limit of #{wallet.name}").deliver(current_user)
      end
    end
  end
end
