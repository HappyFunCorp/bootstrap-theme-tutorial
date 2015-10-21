require 'rails_helper'

RSpec.describe UpdateUserFeedJob, type: :job do
  let( :user ) do 
    user = create( :ig_user )
    user.instagram.update_attribute :accesstoken, ACCESS_TOKEN
    user
  end

  it "should set a job to syncing when it starts" do
    assert_enqueued_with(job: UpdateUserFeedJob) do
      user.sync
    end

    expect( user.state ).to eq( 'queued' )
  end

  it "should set the state to synced when done" do
    VCR.use_cassette( 'instagram/user.wschenk' ) do
      UpdateUserFeedJob.perform_now(user.id)
    end

    user.reload

    expect( user.state ).to eq( 'synced' )
  end

  it "should handle a bad token error" do
    user.instagram.update_attribute :accesstoken, "this_is_wrong"

    VCR.use_cassette( 'instagram/badtoken' ) do
      UpdateUserFeedJob.perform_now(user.id)
    end

    user.reload

    expect( user.state ).to eq( 'broken' )
  end
end
