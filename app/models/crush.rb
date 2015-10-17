class Crush < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged

  belongs_to :user
  belongs_to :instagram_user
  belongs_to :crush_user, class_name: InstagramUser

  def self.find_for_user( user )
    likers = InstagramLike.top_likers_ids user.instagram_user
    comments = InstagramComment.top_commentors_ids user.instagram_user

    results = {}
    comment_total = {}
    liked_total = {}

    likers.each do |v|
      results[v['instagram_user_id']] ||= 0
      results[v['instagram_user_id']] += v['cnt'].to_i
      liked_total[v['instagram_user_id']] = v['cnt'].to_i
    end

    comments.each do |v|
      results[v['instagram_user_id']] ||= 0
      results[v['instagram_user_id']] += v['cnt'].to_i
      comment_total[v['instagram_user_id']] = v['cnt'].to_i

    end

    c = results.sort_by { |id,cnt| -cnt }.first


    slug = (user.instagram_user.username.hash.abs + Time.now.to_i).to_s(36)

    create  user: user, 
            instagram_user_id: user.instagram_user.id, 
            crush_user_id: c[0], 
            comment_count: comment_total[c[0]], 
            liked_count: liked_total[c[0]],
            slug: slug
  end
end
