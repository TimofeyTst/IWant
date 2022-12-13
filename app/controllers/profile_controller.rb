class ProfileController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show
    posts = @user.posts
    @posts_by_three = arr_by_three_columns(posts)
  end

  def destroy
    current_user.avatar.destroy

    respond_to do |format|
      format.html { redirect_to profile_path(current_user), notice: 'Avatar was deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
