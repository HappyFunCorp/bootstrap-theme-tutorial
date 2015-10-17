class CreateCrushes < ActiveRecord::Migration
  def change
    create_table :crushes do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :instagram_user_id
      t.integer :crush_user_id
      t.integer :comment_count
      t.integer :liked_count
      t.string :slug

      t.timestamps null: false
    end

    add_index :crushes, :slug, unique: true
  end
end
