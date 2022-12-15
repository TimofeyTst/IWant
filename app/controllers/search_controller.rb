class SearchController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :user_params

  def index
    @q = Post.ransack(params[:q])

    @posts = Post.ransack(params[:q]).result(distinct: true)
    @users = User.ransack(user_params).result(distinct: true)

    @blocks_by_three = arr_by_three_columns((@posts + @users).shuffle)
    @users_by_three = arr_by_three_columns(@users)
    @posts_by_three = arr_by_three_columns(@posts)
  end

  private

  def user_params
    return unless params[:q]

    { 'username_start' => params[:q][:tags_i_cont_any].to_s }
  end
end
