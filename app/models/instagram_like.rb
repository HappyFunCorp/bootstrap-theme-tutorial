class InstagramLike < ActiveRecord::Base
  belongs_to :instagram_user
  belongs_to :instagram_post
end
