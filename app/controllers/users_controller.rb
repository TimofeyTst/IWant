class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[new create]

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to root_path, notice: 'Successfully registered' }
      else
        format.html { redirect_to new_user_path, notice: 'Errors while create new user' }
      end
    end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@current_user), notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE
  def destroy
    @current_user.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Profile was deleted.' }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :last_login)
  end
end
