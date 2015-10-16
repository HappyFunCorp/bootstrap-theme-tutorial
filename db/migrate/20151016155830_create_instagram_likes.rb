class CreateInstagramLikes < ActiveRecord::Migration
  def change
    create_table :instagram_likes do |t|
      t.integer :instagram_post_id
      t.integer :instagram_user_id

      t.timestamps null: false
    end
  end
end
