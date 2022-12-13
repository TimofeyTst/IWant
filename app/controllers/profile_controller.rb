class ProfileController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show
    @posts_by_three = []
    posts = @user.posts

    if posts.length < 3
      posts.each_slice(1) { |column| @posts_by_three.push(column) }
    elsif (posts.length % 3).zero?
      posts.each_slice(posts.length / 3) { |column| @posts_by_three.push(column) }
    else
      posts.each_slice(posts.length / 3) { |column| @posts_by_three.push(column) }
      @posts_by_three.last.each_with_index { |el, index| @posts_by_three[index].push(el) }
      @posts_by_three.pop
    end
    @posts_by_three
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
