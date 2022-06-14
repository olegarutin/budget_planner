class DeliveryMethods::Webpush < Noticed::DeliveryMethods::Base
  def deliver
    message = params[:planner]
    recipient.webpush_subscriptions.each do |sub|
      sub.send_to_user(message)
    end
  end


  # You may override this method to validate options for the delivery method
  # Invalid options should raise a ValidationError
  #
  # def self.validate!(options)
  #   raise ValidationError, "required_option missing" unless options[:required_option]
  # end
end
