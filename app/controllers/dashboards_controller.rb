class DashboardsController < ApplicationController
  before_action :load_resources, :clear_cache, only: :index

  def index
    @pagy, @transactions = pagy(@transactions)
    return unless @wallets.present?

    scheduler_mail = Rufus::Scheduler.new
    scheduler_mail.every '1h' do
      @wallets.each do |wallet|
        if wallet.quantity.negative?
          PlannerNotification.with(planner: "You've already reached the limit of #{wallet.name} wallet.")
                             .deliver(current_user)
        end
      end
    end

    scheduler_push = Rufus::Scheduler.new
    scheduler_push.every '30s' do
      @wallets.each do |wallet|
        if wallet.quantity.negative?
          WebpushNotification.with(planner_push: "You've already reached the limit of #{wallet.name} wallet.")
                             .deliver(current_user)
        end
      end
    end
  end

  private

  def load_resources
    @categories = Category.all.where(user: [current_user, nil])
    @transactions = current_user.transactions.order(created_at: :desc)
    @wallets = current_user.wallets.order(created_at: :desc)
  end

  def clear_cache
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
  end
end
