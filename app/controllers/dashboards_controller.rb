require 'rufus-scheduler'

class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all.where(user: [current_user, nil])
    @transactions = current_user.transactions
    @wallets = current_user.wallets
    return unless @wallets.present?

    scheduler_mail = Rufus::Scheduler.new
    scheduler_mail.every '12h' do
      @wallets.each do |wallet|
        if wallet.quantity.negative?
          PlannerNotification.with(planner: "You've already reached the limit of #{wallet.name} wallet.")
                             .deliver(current_user)
        end
      end
    end

    scheduler_push = Rufus::Scheduler.new
    scheduler_push.every '1h' do
      @wallets.each do |wallet|
        if wallet.quantity.negative?
          WebpushNotification.with(planner_push: "You've already reached the limit of #{wallet.name} wallet.")
                             .deliver(current_user)
        end
      end
    end
  end
end
