class AddStatsToUser < ActiveRecord::Migration
  def change
    add_column :users, :friend_count, :integer
    add_column :users, :fan_count, :integer
    add_column :users, :star_count, :integer
    add_column :users, :frenemy_count, :integer
    add_column :users, :last_synced, :datetime
    add_column :users, :state, :string
  end
end
