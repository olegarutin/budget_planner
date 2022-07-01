class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!, :turbo_frame_request_variant, :set_images

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def amount_to_number_format(amount)
    (amount.gsub(',', '.').to_f * 100).to_i
  end

  def set_images
    @images = Dir.chdir(Rails.root.join('app/assets/images')) do
      Dir.glob('category/*.png')
    end
  end
end
