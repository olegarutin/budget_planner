class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all.where(user: [current_user, nil])
    @transactions = current_user.transactions
    if current_user.wallets.present?
      current_user.wallets.each do |wallet|
        if wallet.quantity < 0
          PlannerNotification.with(planner: "You've already reached the limit of #{wallet.name}").deliver(current_user)
        end
      end
    end
  end
end
