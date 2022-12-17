class InterestsController < ApplicationController
  include InterestsHelper
  before_action :set_post, only: %i[save unsave]

  def show
    generate_tags_and_usernames
    generate_results
    @results_by_three = arr_by_three_columns((@users + @posts).shuffle)
  end

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
    turbo_stream.replace("save_post_#{@post.id}",
                         partial: 'interests/save_button',
                         locals: { post: @post })
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def generate_results
    @posts = []
    @tags.each do |tag|
      search = Post.ransack({ 'tags_start' => tag }).result(distinct: true)
      @posts += search unless search.nil?
    end
    @users.reject { |user| current_user.followees.include?(user) }
    @posts.uniq!
  end

  def generate_tags_and_usernames
    @followees = current_user.followees
    @saved_posts = current_user.saved_posts
    @sorted_comments = Comment.all.sort_by { |el| -el.likes.count }[0..20]
    # Generate (1+1 + 4*(2+2+1)) tags from posts
    from_last_post
    4.times do
      from_followees
      from_saved
      from_comments
    end
    @tags.uniq!
    @users.uniq!
  end

  def from_last_post
    query = Post.last
    @tags = query.tags.nil? ? [] : query.tags.split
    @users = [query.user]
  end

  def from_followees
    2.times do
      query = @followees&.sample&.posts&.sample&.tags&.split
      @tags += query unless query.nil?
    end
  end

  def from_saved
    2.times do
      query = @saved_posts&.sample&.tags&.split
      @tags += query unless query.nil?
    end
    query = @saved_posts&.sample&.user
    @users.push(query) unless query.nil?
  end

  def from_comments
    query = @sorted_comments&.sample&.post&.tags&.split
    @tags += query unless query.nil?
    query = @sorted_comments&.sample&.user
    @users.push(query) unless query.nil?
  end
end
