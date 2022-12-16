module ProfileHelper
  include ActionView::RecordIdentifier

  def following?(user)
    current_user&.followees&.include?(user)
  end

  def toggled_theme
    current_user.theme == 'light' ? 'dark' : 'light'
  end
end
