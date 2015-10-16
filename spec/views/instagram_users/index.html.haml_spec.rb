require 'rails_helper'

RSpec.describe "instagram_users/index", type: :view do
  before(:each) do
    assign(:instagram_users, [
      InstagramUser.create!(
        :user_id => 1,
        :username => "Username",
        :full_name => "Full Name",
        :profile_picture => "Profile Picture",
        :media_count => 2,
        :followed_count => 3,
        :following_count => 4
      ),
      InstagramUser.create!(
        :user_id => 1,
        :username => "Username",
        :full_name => "Full Name",
        :profile_picture => "Profile Picture",
        :media_count => 2,
        :followed_count => 3,
        :following_count => 4
      )
    ])
  end

  it "renders a list of instagram_users" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Username".to_s, :count => 2
    assert_select "tr>td", :text => "Full Name".to_s, :count => 2
    assert_select "tr>td", :text => "Profile Picture".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
