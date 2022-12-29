class SettingsController < ApplicationController
  # GET /avatar
  def public_profile; end

  def email; end

  def preferences; end

  def avatar; end

  # PATCH/PUT /avatar
  def avatar_update
    respond_to do |format|
      if current_user.update(params.require(:user).permit(:avatar))
        format.html { redirect_to profile_path(current_user) }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def avatar_destroy
    current_user.avatar.destroy

    respond_to do |format|
      format.html { redirect_to profile_path(current_user), notice: 'Avatar was deleted.' }
      format.json { head :no_content }
    end
  end

  def theme
    current_user.update(theme: toggled_theme)
    redirect_to profile_path(current_user), notice: 'Theme changed. Please refresh the page'
    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end
end
