require 'rails_helper'

RSpec.describe "instagram_likes/new", type: :view do
  before(:each) do
    assign(:instagram_like, InstagramLike.new(
      :instagram_post_id => 1,
      :instagram_user_id => 1
    ))
  end

  it "renders new instagram_like form" do
    render

    assert_select "form[action=?][method=?]", instagram_likes_path, "post" do

      assert_select "input#instagram_like_instagram_post_id[name=?]", "instagram_like[instagram_post_id]"

      assert_select "input#instagram_like_instagram_user_id[name=?]", "instagram_like[instagram_user_id]"
    end
  end
end
