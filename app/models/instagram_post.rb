class InstagramPost < ActiveRecord::Base
  belongs_to :instagram_user
  has_many :instagram_comments, dependent: :destroy
  has_many :instagram_commentors, source: :instagram_user, through: :instagram_comments
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
    p.comments_count = media['comments']['count']
    p.likes_count = media['likes']['count']
    p.created_at = Time.at( media['created_time'].to_i )

    p.save

    if p.likes_count < 500
      p.find_media_likes user.instagram_client
      # media['likes']['data'].each do |like|
      #   liker = InstagramUser.reify( like )
      #   InstagramLike.where( instagram_post_id: p.id, instagram_user_id: liker.id ).first_or_create
      # end
    end

    if p.comments_count < 500
      media['comments']['data'].each do |comment|
        commentor = InstagramUser.reify( comment['from'] )
        c = InstagramComment.where( instagram_post_id: p.id, instagram_user_id: commentor.id ).first_or_create
        c.comment = comment['text']
        c.created_at = Time.at( comment['created_time'].to_i )
        c.save
      end
    end

    p
  end

  def find_media_likes client
    client.media_likes( media_id ).each do |like|
      liker = InstagramUser.reify( like )
      InstagramLike.where( instagram_post_id: id, instagram_user_id: liker.id ).first_or_create
    end
  end
end