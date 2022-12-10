class ProfileController < ApplicationController
  def show
    @posts_by_three = []
    posts = Post.all.where(user_id: current_user.id)
    posts.each_slice(3) { |line| @posts_by_three.push(line) }
    @posts_by_three
  end

  def destroy
    current_user.avatar.destroy

    respond_to do |format|
      format.html { redirect_to profile_path(current_user), notice: 'Avatar was deleted.' }
      format.json { head :no_content }
    end
  end
end
