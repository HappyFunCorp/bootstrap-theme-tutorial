ActiveAdmin.register Identity do
  menu priority: 3, label: "Users"

  index do
    selectable_column
    column :id
    column :uid
    column :nickname
    column :name
    column :accesstoken
    column "Image" do |u|
      image_tag u.image
    end
    column :created_at
    actions
  end

end