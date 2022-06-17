require 'rufus-scheduler'

class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all.where(user: [current_user, nil])
    @transactions = current_user.transactions
    @wallets = current_user.wallets
    return unless @wallets.present?

    scheduler = Rufus::Scheduler.new
    scheduler.every '12h' do
      @wallets.each do |wallet|
        if wallet.quantity.negative?
          PlannerNotification.with(planner: "You've already reached the limit of #{wallet.name} wallet.")
                             .deliver(current_user)
        end
      end
    end
  end




end
