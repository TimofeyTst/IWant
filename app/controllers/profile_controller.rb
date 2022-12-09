class ProfileController < ApplicationController
  def show
  end

  def destroy
    current_user.avatar.destroy

    respond_to do |format|
      format.html { redirect_to profile_path(current_user), notice: 'Avatar was deleted.' }
      format.json { head :no_content }
    end
  end
end
