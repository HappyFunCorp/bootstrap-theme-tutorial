require 'rails_helper'

RSpec.describe "instagram_posts/index", type: :view do
  before(:each) do
    assign(:instagram_posts, [
      InstagramPost.create!(
        :user_id => 1,
        :instagram_user_id => 2,
        :media_id => "Media",
        :media_type => "Media Type",
        :comments_count => 3,
        :likes_count => 4,
        :link => "Link",
        :thumbnail_url => "Thumbnail Url",
        :standard_url => "Standard Url"
      ),
      InstagramPost.create!(
        :user_id => 1,
        :instagram_user_id => 2,
        :media_id => "Media",
        :media_type => "Media Type",
        :comments_count => 3,
        :likes_count => 4,
        :link => "Link",
        :thumbnail_url => "Thumbnail Url",
        :standard_url => "Standard Url"
      )
    ])
  end

  it "renders a list of instagram_posts" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Media".to_s, :count => 2
    assert_select "tr>td", :text => "Media Type".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Thumbnail Url".to_s, :count => 2
    assert_select "tr>td", :text => "Standard Url".to_s, :count => 2
  end
end
