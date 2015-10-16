require 'rails_helper'

RSpec.describe "InstagramComments", type: :request do
  describe "GET /instagram_comments" do
    it "works! (now write some real specs)" do
      get instagram_comments_path
      expect(response).to have_http_status(200)
    end
  end
end
