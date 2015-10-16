require 'rails_helper'

RSpec.describe "instagram_posts/edit", type: :view do
  before(:each) do
    @instagram_post = assign(:instagram_post, InstagramPost.create!(
      :user_id => 1,
      :instagram_user_id => 1,
      :media_id => "MyString",
      :media_type => "MyString",
      :comments_count => 1,
      :likes_count => 1,
      :link => "MyString",
      :thumbnail_url => "MyString",
      :standard_url => "MyString"
    ))
  end

  it "renders the edit instagram_post form" do
    render

    assert_select "form[action=?][method=?]", instagram_post_path(@instagram_post), "post" do

      assert_select "input#instagram_post_user_id[name=?]", "instagram_post[user_id]"

      assert_select "input#instagram_post_instagram_user_id[name=?]", "instagram_post[instagram_user_id]"

      assert_select "input#instagram_post_media_id[name=?]", "instagram_post[media_id]"

      assert_select "input#instagram_post_media_type[name=?]", "instagram_post[media_type]"

      assert_select "input#instagram_post_comments_count[name=?]", "instagram_post[comments_count]"

      assert_select "input#instagram_post_likes_count[name=?]", "instagram_post[likes_count]"

      assert_select "input#instagram_post_link[name=?]", "instagram_post[link]"

      assert_select "input#instagram_post_thumbnail_url[name=?]", "instagram_post[thumbnail_url]"

      assert_select "input#instagram_post_standard_url[name=?]", "instagram_post[standard_url]"
    end
  end
end
