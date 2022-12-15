module InterestsHelper
  def saved?(post)
    CollectionSavedPost.where(user_id: current_user.id, post_id: post.id).any?
  end
end
