class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  include ApplicationHelper

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[username])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[avatar username email password_confirmation current_password])
  end
end
