json.extract! post, :id, :user_id, :tags, :description, :picture, :created_at, :updated_at
json.url post_url(post, format: :json)
json.picture url_for(post.picture)
