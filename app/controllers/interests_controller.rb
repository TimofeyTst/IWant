class InterestsController < ApplicationController
  include InterestsHelper
  before_action :set_post, only: %i[save unsave]

  def saved
    @posts_by_three = arr_by_three_columns(User.find(current_user.id).saved_posts)
  end

  def save
    new_post = CollectionSavedPost.create_or_find_by(user_id: current_user.id, post_id: @post.id)
    new_post.save

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: private_stream
      end
    end
  end

  def unsave
    CollectionSavedPost.where(user_id: current_user.id, post_id: @post.id).destroy_all

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: private_stream
      end
    end
  end

  private

  def private_stream
    turbo_stream.replace(helpers.dom_id(@post),
                         partial: 'posts/post',
                         locals: { post: @post })
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
