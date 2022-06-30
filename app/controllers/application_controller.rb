class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :turbo_frame_request_variant, :set_cache_buster

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def set_cache_buster
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
  end

  def amount_to_number_format(amount)
    (amount.gsub(',', '.').to_f * 100).to_i
  end
end
