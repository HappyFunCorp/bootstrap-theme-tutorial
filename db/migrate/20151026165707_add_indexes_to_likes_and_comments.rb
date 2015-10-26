class AddIndexesToLikesAndComments < ActiveRecord::Migration
  def change
    add_index :instagram_likes, [:instagram_post_id, :instagram_user_id], :name => 'likes_post_user'
    add_index :instagram_comments, [:instagram_post_id, :instagram_user_id], :name => "comments_post_user"
  end
end
