require "rails_helper"

RSpec.describe InstagramLikesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/instagram_likes").to route_to("instagram_likes#index")
    end

    it "routes to #new" do
      expect(:get => "/instagram_likes/new").to route_to("instagram_likes#new")
    end

    it "routes to #show" do
      expect(:get => "/instagram_likes/1").to route_to("instagram_likes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/instagram_likes/1/edit").to route_to("instagram_likes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/instagram_likes").to route_to("instagram_likes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/instagram_likes/1").to route_to("instagram_likes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/instagram_likes/1").to route_to("instagram_likes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/instagram_likes/1").to route_to("instagram_likes#destroy", :id => "1")
    end

  end
end
