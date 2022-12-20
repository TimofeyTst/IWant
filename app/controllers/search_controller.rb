class SearchController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @posts = Post.ransack(post_params).result(distinct: true)

    @posts_by_three = arr_by_three_columns(@posts)
  end

  private

  def user_params
    { 'username_start' => params[:query] }
  end

  def post_params
    { 'tags_i_cont_any' => params[:query] }
  end
end
