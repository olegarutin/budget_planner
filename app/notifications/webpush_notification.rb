class WebpushNotification < Noticed::Base
  deliver_by :webpush, class: "DeliveryMethods::Webpush"

  param :planner_push
end
