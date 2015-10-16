require 'rails_helper'

RSpec.describe "InstagramPosts", type: :request do
  describe "GET /instagram_posts" do
    it "works! (now write some real specs)" do
      get instagram_posts_path
      expect(response).to have_http_status(200)
    end
  end
end
