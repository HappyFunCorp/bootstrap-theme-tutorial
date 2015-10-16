json.array!(@instagram_comments) do |instagram_comment|
  json.extract! instagram_comment, :id, :instagram_post_id, :instagram_user_id, :comment
  json.url instagram_comment_url(instagram_comment, format: :json)
end
