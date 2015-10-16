require "rails_helper"

RSpec.describe InstagramPostsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/instagram_posts").to route_to("instagram_posts#index")
    end

    it "routes to #new" do
      expect(:get => "/instagram_posts/new").to route_to("instagram_posts#new")
    end

    it "routes to #show" do
      expect(:get => "/instagram_posts/1").to route_to("instagram_posts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/instagram_posts/1/edit").to route_to("instagram_posts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/instagram_posts").to route_to("instagram_posts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/instagram_posts/1").to route_to("instagram_posts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/instagram_posts/1").to route_to("instagram_posts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/instagram_posts/1").to route_to("instagram_posts#destroy", :id => "1")
    end

  end
end
