require 'rails_helper'

USER_DATA={
               "id" => "509161",
         "username" => "wschenk",
              "bio" => "",
          "website" => "",
  "profile_picture" => "https://instagramimages-a.akamaihd.net/profiles/profile_509161_75sq_1391538024.jpg",
        "full_name" => "Will Schenk",
           "counts" => {
              "media" => 642,
        "followed_by" => 158,
            "follows" => 218
          }
}

RSpec.describe InstagramUser, :type => :model do
  it "should create a new instagram user from a user object" do
    expect( InstagramUser.all.count ).to eq( 0 )

    u = create( :user )

    self_user = InstagramUser.reify( USER_DATA, u )

    i = InstagramUser.first

    expect( i.username ).to eq( "wschenk" )
    expect( i.full_name ).to eq( "Will Schenk" )
    expect( i.user_id ).to eq( u.id )
    expect( i.profile_picture ).to eq( "https://instagramimages-a.akamaihd.net/profiles/profile_509161_75sq_1391538024.jpg" )
    expect( i.media_count ).to eq( 642 )
    expect( i.followed_count ).to eq( 158 )
    expect( i.following_count ).to eq( 218 )
    expect( InstagramUser.all.count ).to eq(1)

    u = User.find u.id

    expect( u.instagram_user ).to eq( i )
  end

  it "should not create 2 of the same users" do 
    u = create(:user)
    InstagramUser.reify( USER_DATA, u )
    InstagramUser.reify( USER_DATA, u )

    expect( InstagramUser.all.count ).to eq(1)
  end
end
