class InstagramUser < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_many :instagram_posts, dependent: :destroy
  friendly_id :username, use: :slugged

  def slug
    username
  end
  
  def self.reify( data, user = nil )
    # p data
    u = where( :username => data['username']).first_or_create
    u.user_id = user.id if user
    u.username = data['username']
    u.full_name = data['full_name']
    u.profile_picture = data['profile_picture']
    if data['counts']
      u.media_count = data['counts']['media']
      u.followed_count = data['counts']['followed_by']
      u.following_count = data['counts']['follows']
    end
    
    u.save

    u
  end
end
