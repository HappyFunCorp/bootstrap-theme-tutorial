ActiveAdmin.register Crush do
  menu priority: 2
  filter :main_username
  filter :crush_username
  filter :created_at
  filter :comment_count
  filter :liked_count


  index do
    selectable_column
    column :id
    column :main_username do |c|
      link_to c.main_username, admin_instagram_user_path( c.main_username )
    end
    column :crush_username do |c|
      link_to c.crush_username, admin_instagram_user_path( c.crush_username )
    end
    column :comment_count
    column :liked_count

    column "Shared Image" do |c|
      link_to image_tag( c.image_path ), crush_path( c )
    end
    column :created_at
    actions
  end



  controller do
    def find_resource
      Crush.where(slug: params[:id]).first!
    end
  end
end