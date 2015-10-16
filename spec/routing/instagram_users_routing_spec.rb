require "rails_helper"

RSpec.describe InstagramUsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/instagram_users").to route_to("instagram_users#index")
    end

    it "routes to #new" do
      expect(:get => "/instagram_users/new").to route_to("instagram_users#new")
    end

    it "routes to #show" do
      expect(:get => "/instagram_users/1").to route_to("instagram_users#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/instagram_users/1/edit").to route_to("instagram_users#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/instagram_users").to route_to("instagram_users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/instagram_users/1").to route_to("instagram_users#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/instagram_users/1").to route_to("instagram_users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/instagram_users/1").to route_to("instagram_users#destroy", :id => "1")
    end

  end
end
