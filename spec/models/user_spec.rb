require 'rails_helper'

ACCESS_TOKEN='509161.38c3f84.7d662d3ec84347f99b9574ef10168de1'

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
end