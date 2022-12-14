module ProfileHelper
  include ActionView::RecordIdentifier

  def following?(user)
    current_user&.followees&.include?(user)
  end
end
