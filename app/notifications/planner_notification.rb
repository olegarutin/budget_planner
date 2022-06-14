# To deliver this notification:
#
# PlannerNotification.with(post: @post).deliver_later(current_user)
# PlannerNotification.with(post: @post).deliver(current_user)

class PlannerNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :webpush, class: "DeliveryMethods::Webpush"
  deliver_by :email, mailer: "PlannerMailer", delay: 10.minutes, if: :unread?

  param :planner

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
end
