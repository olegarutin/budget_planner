class DeliveryMethods::Webpush < Noticed::DeliveryMethods::Base
  def deliver
    message = params[:planner_push]
    recipient.webpush_subscriptions.each do |sub|
      sub.send_to_user(message)
    end
  end
end
