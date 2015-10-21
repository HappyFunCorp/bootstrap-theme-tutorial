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
end