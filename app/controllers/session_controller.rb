class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      sign_in user
      redirect_to root_path, notice: 'Successfully log in'
    else
      redirect_to session_new_path, notice: 'Invalid login or password'
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: 'Successfully log out'
  end
end
