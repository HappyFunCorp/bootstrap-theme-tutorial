require 'rails_helper'

RSpec.describe "InstagramLikes", type: :request do
  describe "GET /instagram_likes" do
    it "works! (now write some real specs)" do
      get instagram_likes_path
      expect(response).to have_http_status(200)
    end
  end
end
