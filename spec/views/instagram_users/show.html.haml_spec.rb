require 'rails_helper'

RSpec.describe "instagram_users/show", type: :view do
  before(:each) do
    @instagram_user = assign(:instagram_user, InstagramUser.create!(
      :user_id => 1,
      :username => "Username",
      :full_name => "Full Name",
      :profile_picture => "Profile Picture",
      :media_count => 2,
      :followed_count => 3,
      :following_count => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Full Name/)
    expect(rendered).to match(/Profile Picture/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
