class InstagramComment < ActiveRecord::Base
  belongs_to :instagram_user
  belongs_to :instagram_post

  def self.top_commentors_ids( instagram_user )
    top_commentors_ids_sql =  
                      "select count(*) as cnt, instagram_user_id " \
                      "from instagram_comments " \
                      "where instagram_post_id in "\
                      "(select instagram_posts.id from instagram_posts "\
                      "where instagram_user_id = #{instagram_user.id}) "\
                      "group by instagram_user_id order by cnt desc limit 5"

    connection.execute top_commentors_ids_sql
  end
end