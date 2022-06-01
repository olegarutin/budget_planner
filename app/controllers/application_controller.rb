class ApplicationController < ActionController::Base
  before_action :turbo_frame_request_variant

  private

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end

  def after_sign_in_path_for(resource)
    dashboards_path
  end
end
