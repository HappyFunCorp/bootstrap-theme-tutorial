json.array!(@instagram_likes) do |instagram_like|
  json.extract! instagram_like, :id, :instagram_post_id, :instagram_user_id
  json.url instagram_like_url(instagram_like, format: :json)
end
