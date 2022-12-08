class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :require_login

  private

  def require_login
    return if signed_in?

    redirect_to session_new_path, notice: 'Please sign in'
  end
end
