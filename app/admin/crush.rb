ActiveAdmin.register Crush do
  menu priority: 2
  filter :main_username
  filter :crush_username
  filter :created_at

  index do
    selectable_column
    column :id
    column :main_username
    column :crush_username
    column "Shared Image" do |u|
      image_tag u.image_path
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