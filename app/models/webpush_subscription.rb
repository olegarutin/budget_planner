class WebpushSubscription < ApplicationRecord
  belongs_to :user

	def send_to_user(message)
    Webpush.payload_send(
        message: message, 
        endpoint: endpoint, 
        auth: auth_key, 
        p256dh: p256dh_key, 
        vapid: {
          private_key: ENV['WEBPUSH_PRIVATE_KEY'], 
          public_key: ENV['WEBPUSH_PUBLIC_KEY']
        }
      )
  end
end
