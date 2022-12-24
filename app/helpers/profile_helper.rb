module ProfileHelper
  include ActionView::RecordIdentifier

  def toggled_theme
    current_user.theme == 'light' ? 'dark' : 'light'
  end
end
