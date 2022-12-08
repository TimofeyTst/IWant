module ApplicationHelper
  def sign_in(user)
    session[:user_id] = user.id
    user.touch(:last_login)
    @current_user = user
  end

  def signed_in?
    puts '============================='
    puts "@current_user = #{@current_user}"
    puts "self.current_user = #{current_user}"
    puts '============================='
    !@current_user.nil?
  end

  def sign_out
    session[:user_id] = nil
    @current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
