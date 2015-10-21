require 'rails_helper'

Crush
class Crush
  def make_image
  end
end

RSpec.describe Crush, type: :model do
  let( :user ) { create( :ig_user ) }
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

  describe "testing the test harness" do
    it "should create a post" do
      post( [bschippers, holly], [alanna] )
      expect( InstagramPost.count ).to eq( 1 )
      expect( InstagramUser.count ).to eq( 4 )
      expect( InstagramLike.count ).to eq( 2 )
      expect( InstagramComment.count ).to eq( 1 )
    end
  end

  it "should create a crush for a user" do
    post( [], [alanna] )

    crush = user.crush

    expect( crush ).to_not be_nil
    expect( crush.crush_user.username ).to eq( "alanna" )
  end

  it "should have a slug set" do
    post [bschippers,holly], []
    post [holly], []

    crush = user.crush
    expect( crush.slug ).to_not be_blank
  end
end
