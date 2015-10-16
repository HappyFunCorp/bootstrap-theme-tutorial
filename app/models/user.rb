class User < ActiveRecord::Base
  has_one :instagram_user

  has_many :identities, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  def instagram
    identities.where( :provider => "instagram" ).first
  end

  def instagram_client
    @instagram_client ||= Instagram.client( access_token: instagram.accesstoken )
  end

  def stale?
    return true if last_synced.nil?
    last_synced < 1.day.ago
  end

  def sync!
    return false if !stale?

    iu = InstagramUser.reify( instagram_client.user, self )
    update_attribute( :last_synced, Time.now )
    reload
    iu
  end

  def sync_instagram_posts
    return false if !stale?

    self_user = InstagramUser.reify( instagram_client.user, self )

    instagram_client.user_recent_media.each do |media|
      InstagramPost.reify( media, self_user, self )
    end

    update_attribute( :last_synced, Time.now )
    reload
  end

end
