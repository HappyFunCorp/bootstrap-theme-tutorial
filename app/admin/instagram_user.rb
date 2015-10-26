ActiveAdmin.register InstagramUser do
  menu priority: 4

  filter :username
  filter :full_name
  filter :created_at
  filter :media_count
  filter :followed_count
  filter :following_count


  index do
    selectable_column
    column :id
    column :username
    column :full_name
    column "Profile" do |u|
      image_tag u.profile_picture
    end
    column "Latest Crush" do |u|
      c = u.user && u.user.crushes.order( "created_at desc" ).first
      link_to c.crush_username, admin_crush_path( c ) if c
    end
    column :media_count
    column :followed_count
    column :following_count
    column :created_at
    actions
  end

  member_action :sync_user, method: :put do
    resource.user.refresh
    resource.user.sync
    redirect_to resource_path, notice: "Syning user!"
  end

  action_item "Sync User", only: :show do
    link_to "Sync User", sync_user_admin_instagram_user_path( resource ), method: :put 
  end

  controller do
    def find_resource
      InstagramUser.where(username: params[:id]).first!
    end
  end
  
end