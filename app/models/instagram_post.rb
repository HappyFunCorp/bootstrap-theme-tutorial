class InstagramPost < ActiveRecord::Base
  belongs_to :instagram_user
  has_many :instagram_comments, dependent: :destroy
  has_many :instagram_likes, dependent: :destroy
  has_many :instagram_likers, source: :instagram_user, through: :instagram_likes

  def self.reify( media, instagram_user, user )
    p = where( media_id: media['id'] ).first_or_create

    p.user_id = user.id
    p.instagram_user = InstagramUser.reify( media['user'] )
    p.media_type = media['type']
    p.link = media['link']
    p.thumbnail_url = media['images']['thumbnail']['url']
    p.standard_url = media['images']['standard_resolution']['url']

    p.save

    media['likes']['data'].each do |like|
      liker = InstagramUser.reify( like )
      InstagramLike.where( instagram_post_id: p.id, instagram_user_id: liker.id ).first_or_create
    end

    media['comments']['data'].each do |comment|
      commentor = InstagramUser.reify( comment )
      c = InstagramComment.where( instagram_post_id: p.id, instagram_user_id: commentor.id ).first_or_create
      c.comment = comment['text']
    end

    p
  end
end