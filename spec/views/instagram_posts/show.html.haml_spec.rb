require 'rails_helper'

RSpec.describe "instagram_posts/show", type: :view do
  before(:each) do
    @instagram_post = assign(:instagram_post, InstagramPost.create!(
      :user_id => 1,
      :instagram_user_id => 2,
      :media_id => "Media",
      :media_type => "Media Type",
      :comments_count => 3,
      :likes_count => 4,
      :link => "Link",
      :thumbnail_url => "Thumbnail Url",
      :standard_url => "Standard Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Media/)
    expect(rendered).to match(/Media Type/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Thumbnail Url/)
    expect(rendered).to match(/Standard Url/)
  end
end
