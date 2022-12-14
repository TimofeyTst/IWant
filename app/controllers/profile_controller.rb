class ProfileController < ApplicationController
  include ProfileHelper

  before_action :set_user, only: %i[show follow unfollow]
  skip_before_action :authenticate_user!, only: :show

  def show
    posts = @user.posts
    @posts_by_three = arr_by_three_columns(posts)
  end

  def destroy_avatar
    current_user.avatar.destroy

    respond_to do |format|
      format.html { redirect_to profile_path(current_user), notice: 'Avatar was deleted.' }
      format.json { head :no_content }
    end
  end

  def follow
    Relationship.create_or_find_by(follower_id: current_user.id, followee_id: @user.id)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(dom_id(@user),
                               partial: 'profile/follow_button',
                               locals: { user: @user }),
          turbo_stream.update("#{@user.id}-follower-count",
                              partial: 'profile/follower_count',
                              locals: { user: @user })
        ]
      end
    end
  end

  def unfollow
    current_user.followed_users.where(follower_id: current_user.id, followee_id: @user.id).destroy_all
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(dom_id(@user),
                               partial: 'profile/follow_button',
                               locals: { user: @user }),
          turbo_stream.update("#{@user.id}-follower-count",
                              partial: 'profile/follower_count',
                              locals: { user: @user })
        ]
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
