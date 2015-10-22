require 'rails_helper'

RSpec.describe CrushesController, type: :controller do
    let( :user ) do 
      user = create( :ig_user )
      create( :instagram_user, user: user )
      user.instagram.update_attribute :accesstoken, ACCESS_TOKEN
      user
    end

  let( :wschenk ) { create( :instagram_user, user: user, username: "wschenk", full_name: "Will") }
  let( :bschippers ) { create( :instagram_user, username: "bschippers", full_name: "Ben") }
  let( :abrocken ) { create( :instagram_user, username: "abrocken", full_name: "abrocken") }
  let( :holly ) { create( :instagram_user, username: "holly", full_name: "holly") }
  let( :alanna ) { create( :instagram_user, username: "alanna", full_name: "alanna") }

  def post( likers, commentors )
    post = create( :instagram_post, instagram_user: wschenk )
    likers.each do |like_user|
      post.instagram_likers << like_user
    end
    commentors.each do |commentor|
      post.instagram_comments.create( instagram_user: commentor, comment: "Hi there" )
    end
  end

  context "crush index" do
    let( :crush ) { create( :crush, slug: "1234", user: user, instagram_user: wschenk, crush_user: alanna ) }

    it "should just redirect for a recently synced user" do
      post( [bschippers, holly, alanna], [alanna] )

      expect( crush ).to_not be_nil

      user.update_attribute :last_synced, 1.hour.ago

      login_with user
      get :index

      expect( response ).to redirect_to( crush_path( crush ) )
    end

    it "should just redirect for a recently synced user" do
      post( [bschippers, holly, alanna], [alanna] )

      expect( crush ).to_not be_nil

      user.update_attribute :last_synced, 2.days.ago

      login_with user
      assert_enqueued_with(job: UpdateUserFeedJob) do
        get :index
      end

      expect( response ).to redirect_to( loading_crush_path )

    end
  end

  context "loading page" do
    let( :crush ) { create( :crush, slug: "1234", user: user ) }

    it "should redirect to instagram user for anonymous user" do
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

    it "should log out the user and redirect to root when it's broken" do
      expect( controller ).to receive( :sign_out )
      user.update_attribute :state, 'broken'
      user.reload

      login_with user

      get :loading

      expect( response ).to redirect_to( root_path )
      expect( flash[:notice] ).to eq( "Problem syncing your account, please try again" )
    end

    it "should return json when that format is requested" do
      post( [bschippers, holly, alanna], [alanna] )
      login_with user

      get :loading, format: :json

      results = JSON.parse response.body

      expect( results.length ).to eq(3)
    end
  end
end