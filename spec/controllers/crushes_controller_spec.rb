require 'rails_helper'

RSpec.describe CrushesController, type: :controller do
  context "loading page" do
    let( :user ) do 
      user = create( :ig_user )
      user.instagram.update_attribute :accesstoken, ACCESS_TOKEN
      user
    end
    let( :crush ) { create( :crush, slug: "1234", user: user ) }

    it "should return instagram user" do
      login_with nil
      get :loading

      expect( response ).to redirect_to( user_omniauth_authorize_path( :instagram ) )
    end

    it "should redirect to the crush once it's loaded" do
      expect( user ).to receive( :crush ).and_return( crush )
      user.update_attribute :state, 'synced'
      user.reload

      login_with user

      get :loading

      expect( response ).to redirect_to( crush_path( crush ) )
    end

    it "should return json when that format is requested" do
      login_with user

      get :loading, format: :json

      p response.body
    end
  end
end