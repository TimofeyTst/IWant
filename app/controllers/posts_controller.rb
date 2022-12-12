class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :have_permission?, only: %i[edit update destroy]

  # GET /posts or /posts.json
  def index
    @posts_by_three = []
    posts = Post.all.shuffle

    if (posts.length % 3).zero?
      posts.each_slice(posts.length / 3) { |line| @posts_by_three.push(line) }
    else
      posts.each_slice(posts.length / 3) { |line| @posts_by_three.push(line) }
      @posts_by_three.last.each_with_index { |el, index| @posts_by_three[index].push(el) }
      @posts_by_three.pop
    end
    @posts_by_three
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    redirect_to post_url(@post), notice: 'Don`t have permission' unless have_permission? 
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    return unless have_permission?

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    return unless have_permission?

    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def have_permission?
    current_user == @post.user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:user_id, :tags, :description, :picture)
  end
end
