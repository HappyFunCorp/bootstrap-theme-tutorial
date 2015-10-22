require 'rails_helper'

RSpec.describe User, type: :model do
  describe "staleness" do
    it "should be stale if never synced" do
      u = build( :user )
      expect( u.stale? ).to be_truthy
    end

    it "should be stale if synched more than a day ago" do
      u = build( :user, last_synced: 2.days.ago )
      expect( u.stale? ).to be_truthy
    end

    it "should not be stale if synched an hour ago" do
      u = build( :user, last_synced: 1.hour.ago )
      expect( u.stale? ).to be_falsey
    end
  end

  it "should not sync when the user is not stale" do
    user = create( :user, last_synced: 1.hour.ago )
    identity = create :identity, user: user, provider: :instagram, accesstoken: ACCESS_TOKEN

    expect( user.stale? ).to be_falsey
    user.sync!
  end

  it "should sync when the user is stale" do
    user = create( :user )
    identity = create :identity, user: user, provider: :instagram, accesstoken: ACCESS_TOKEN

    expect( user.instagram_user ).to be_nil

    expect( user.stale? ).to be_truthy

    VCR.use_cassette( 'instagram/user.wschenk' ) do
      user.sync!
    end

    expect( user.instagram_user ).to_not be_nil
    expect( user.last_synced ).to_not be_nil
  end

  context "states" do
    let( :user ) { build( :user ) }

    it "should be stale by default" do
      expect( user.stale? ).to be_truthy
    end

    it "should be queuable by default" do
      expect( user.queueable? ).to be_truthy
    end

    it "should not be queable if it's queued already" do
      user.update_attribute :state, :queued
      user.reload
      expect( user.queueable? ).to be_falsey
    end
  end

  context "connected users" do
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

    it "should return an empty list if there are no users" do
      expect( InstagramUser.count ).to eq( 0 )
      expect( user.connected_instagram_users ).to eq( [] )
    end

    it "should return an empty list if there are no connections" do
      post [], []
      expect( user.connected_instagram_users ).to eq( [] )
    end

    it "should reutnr users connected to the main user" do
      post [holly, bschippers], [alanna]

      connected_users = user.connected_instagram_users

      expect( connected_users ).to contain_exactly( alanna, holly, bschippers )
    end

    it "should filter doubles" do
      post [holly, bschippers], [alanna, holly]

      connected_users = user.connected_instagram_users

      expect( connected_users ).to contain_exactly( alanna, holly, bschippers )
    end
  end
end