<<<<<<< HEAD:app/models/webpush_subscription.rb
class WebpushSubscription < ApplicationRecord

	 def send_to_user(message)
=======
class Notification < ApplicationRecord
  belongs_to :user
  
	def send(message)
>>>>>>> 8eb9b09e69eed448ed8f04afeb366f5cbb6ba2b0:app/models/notification.rb
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
