class CreateInstagramComments < ActiveRecord::Migration
  def change
    create_table :instagram_comments do |t|
      t.integer :instagram_post_id
      t.integer :instagram_user_id
      t.string :comment

      t.timestamps null: false
    end
  end
end
