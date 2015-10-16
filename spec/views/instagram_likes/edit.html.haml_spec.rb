require 'rails_helper'

RSpec.describe "instagram_likes/edit", type: :view do
  before(:each) do
    @instagram_like = assign(:instagram_like, InstagramLike.create!(
      :instagram_post_id => 1,
      :instagram_user_id => 1
    ))
  end

  it "renders the edit instagram_like form" do
    render

    assert_select "form[action=?][method=?]", instagram_like_path(@instagram_like), "post" do

      assert_select "input#instagram_like_instagram_post_id[name=?]", "instagram_like[instagram_post_id]"

      assert_select "input#instagram_like_instagram_user_id[name=?]", "instagram_like[instagram_user_id]"
    end
  end
end
