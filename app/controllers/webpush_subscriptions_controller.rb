class WebpushSubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index; end

  def create
    @webpush_subscription = WebpushSubscription.find_by(auth_key: params[:keys][:auth])
    if !@webpush_subscription
      @webpush_subscription = WebpushSubscription.new(
          user: current_user,
          endpoint: params[:endpoint],
          auth_key: params[:keys][:auth],
          p256dh_key: params[:keys][:p256dh]
        )
    end
    if @webpush_subscription.save
      render json: @webpush_subscription
    else
      render json: @webpush_subscription.errors.full_messages.first
    end
  end
end
