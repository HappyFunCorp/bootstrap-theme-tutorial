ActiveAdmin.register InstagramComment do
  menu priority: 5

  config.filters = false

  # filter :username
  # filter :full_name
  # filter :created_at

  index do
    selectable_column
    column :id

    column "user" do |c|
      link_to c.instagram_user.username, admin_instagram_user_path( c.instagram_user )
    end

    column "post" do |c|
      image_tag c.instagram_post.thumbnail_url
    end

    column :comment
  end

  # controller do
  #   def find_resource
  #     InstagramUser.where(username: params[:id]).first!
  #   end
  # end
  
end