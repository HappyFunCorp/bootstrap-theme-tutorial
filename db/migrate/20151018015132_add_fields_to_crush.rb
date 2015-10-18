class AddFieldsToCrush < ActiveRecord::Migration
  def change
    add_column :crushes, :main_username, :string
    add_column :crushes, :crush_username, :string
    add_column :crushes, :image_path, :string

    Crush.destroy_all
  end
end
