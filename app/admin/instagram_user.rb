ActiveAdmin.register InstagramUser do
  menu priority: 4

  filter :username
  filter :full_name
  filter :created_at

  index do
    selectable_column
    column :id
    column :username
    column :full_name
    column "Profile" do |u|
      image_tag u.profile_picture
    end
    column :created_at
    actions
  end

  controller do
    def find_resource
      InstagramUser.where(username: params[:id]).first!
    end
  end
  
end