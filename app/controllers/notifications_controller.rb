class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index; end

  def create
    @notification = Notification.find_by(auth_key: params[:keys][:auth])
    if !@notification
      @notification = Notification.new(
          endpoint: params[:endpoint],
          auth_key: params[:keys][:auth],
          p256dh_key: params[:keys][:p256dh],
          user: current_user
        )
    end
    if @notification.save
      render json: @notification
    else
      render json: @notification.errors.full_messages.first
    end
  end
end
