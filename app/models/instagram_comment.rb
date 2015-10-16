class InstagramComment < ActiveRecord::Base
  has_one :instagram_user
  belongs_to :instagram_post
end