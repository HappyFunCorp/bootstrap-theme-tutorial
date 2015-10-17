require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #landing" do
    before( :each ) do
      allow_message_expectations_on_nil
    end
    
    it "returns http success for regular users" do
      login_with nil
      get :landing
      expect(response).to have_http_status(:success)
    end

    it "redirects to show crush page when there is a user" do
      login_with create( :ig_user, last_synced: 1.hour.ago )
      get :landing
      expect( response ).to redirect_to( crushes_path )
    end
  end


end
