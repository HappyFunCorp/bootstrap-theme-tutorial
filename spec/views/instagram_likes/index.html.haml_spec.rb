require 'rails_helper'

RSpec.describe "instagram_likes/index", type: :view do
  before(:each) do
    assign(:instagram_likes, [
      InstagramLike.create!(
        :instagram_post_id => 1,
        :instagram_user_id => 2
      ),
      InstagramLike.create!(
        :instagram_post_id => 1,
        :instagram_user_id => 2
      )
    ])
  end

  it "renders a list of instagram_likes" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
