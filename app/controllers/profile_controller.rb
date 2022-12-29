class ProfileController < ApplicationController
  include ProfileHelper

  before_action :set_user, only: %i[show follow unfollow followers following theme]
  skip_before_action :authenticate_user!, only: :show

  def show
    posts = @user.posts
    @posts_by_three = arr_by_three_columns(posts)
  end

  def followers
    @users_by_three = arr_by_three_columns(@user.followers)
  end

  def following
    @users_by_three = arr_by_three_columns(@user.following)
  end

  def settings
  end

  def follow
    current_user.send_follow_request_to(@user)
    @user.accept_follow_request_of(current_user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: private_stream
      end
    end
  end

  def unfollow
    current_user.unfollow(@user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: private_stream
      end
    end
  end

  private

  def private_stream
    [
      turbo_stream.replace(dom_id(@user),
                           partial: 'profile/follow_button',
                           locals: { user: @user }),
      turbo_stream.update("#{@user.id}-follower-count",
                          partial: 'profile/follower_count',
                          locals: { user: @user })
    ]
  end

  def set_user
    @user = User.find(params[:id])
  end
end
