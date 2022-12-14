class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created'
    else
      redirect_to post_path(@post), notice: 'Errors while creating comment'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was destroyed'
  end

  def like
    @comment = @post.comments.find(params[:id])
    current_user.like(@comment)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: private_stream
      end
    end
  end

  private

  def private_stream
    private_target = "#{helpers.dom_id(@comment)} private_likes"
    turbo_stream.replace(private_target,
                         partial: 'likes/private_button',
                         locals: { post: @post,
                                   comment: @comment,
                                   like_status: current_user.liked?(@comment) })
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
