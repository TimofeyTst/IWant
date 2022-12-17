class SearchController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @q = Post.ransack(params[:q])

    @posts = @q.result(distinct: true)

    @posts_by_three = arr_by_three_columns(@posts)
  end
end
