require 'rails_helper'

RSpec.describe "instagram_users/new", type: :view do
  before(:each) do
    assign(:instagram_user, InstagramUser.new(
      :user_id => 1,
      :username => "MyString",
      :full_name => "MyString",
      :profile_picture => "MyString",
      :media_count => 1,
      :followed_count => 1,
      :following_count => 1
    ))
  end

  it "renders new instagram_user form" do
    render

    assert_select "form[action=?][method=?]", instagram_users_path, "post" do

      assert_select "input#instagram_user_user_id[name=?]", "instagram_user[user_id]"

      assert_select "input#instagram_user_username[name=?]", "instagram_user[username]"

      assert_select "input#instagram_user_full_name[name=?]", "instagram_user[full_name]"

      assert_select "input#instagram_user_profile_picture[name=?]", "instagram_user[profile_picture]"

      assert_select "input#instagram_user_media_count[name=?]", "instagram_user[media_count]"

      assert_select "input#instagram_user_followed_count[name=?]", "instagram_user[followed_count]"

      assert_select "input#instagram_user_following_count[name=?]", "instagram_user[following_count]"
    end
  end
end
