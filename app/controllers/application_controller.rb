class ApplicationController < ActionController::Base
  before_action :turbo_frame_request_variant
  before_action :set_cache_buster

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end

  def after_sign_in_path_for(resource)
    dashboards_path
  end

  def set_cache_buster
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
  end
end
