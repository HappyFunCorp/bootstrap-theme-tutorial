json.array!(@instagram_posts) do |instagram_post|
  json.extract! instagram_post, :id, :user_id, :instagram_user_id, :media_id, :media_type, :comments_count, :likes_count, :link, :thumbnail_url, :standard_url
  json.url instagram_post_url(instagram_post, format: :json)
end
