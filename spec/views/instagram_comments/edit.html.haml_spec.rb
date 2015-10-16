require 'rails_helper'

RSpec.describe "instagram_comments/edit", type: :view do
  before(:each) do
    @instagram_comment = assign(:instagram_comment, InstagramComment.create!(
      :instagram_post_id => 1,
      :instagram_user_id => 1,
      :comment => "MyString"
    ))
  end

  it "renders the edit instagram_comment form" do
    render

    assert_select "form[action=?][method=?]", instagram_comment_path(@instagram_comment), "post" do

      assert_select "input#instagram_comment_instagram_post_id[name=?]", "instagram_comment[instagram_post_id]"

      assert_select "input#instagram_comment_instagram_user_id[name=?]", "instagram_comment[instagram_user_id]"

      assert_select "input#instagram_comment_comment[name=?]", "instagram_comment[comment]"
    end
  end
end
