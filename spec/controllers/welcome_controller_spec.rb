require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #landing" do
    it "returns http success" do
      get :landing
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show_feed" do
    it "returns http success" do
      get :show_feed
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #loading_crush" do
    it "returns http success" do
      get :loading_crush
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show_crush" do
    it "returns http success" do
      get :show_crush
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #friends" do
    it "returns http success" do
      get :friends
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #frenemies" do
    it "returns http success" do
      get :frenemies
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #fans" do
    it "returns http success" do
      get :fans
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #stars" do
    it "returns http success" do
      get :stars
      expect(response).to have_http_status(:success)
    end
  end

end
