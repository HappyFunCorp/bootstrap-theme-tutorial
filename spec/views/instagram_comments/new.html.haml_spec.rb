require 'rails_helper'

RSpec.describe "instagram_comments/new", type: :view do
  before(:each) do
    assign(:instagram_comment, InstagramComment.new(
      :instagram_post_id => 1,
      :instagram_user_id => 1,
      :comment => "MyString"
    ))
  end

  it "renders new instagram_comment form" do
    render

    assert_select "form[action=?][method=?]", instagram_comments_path, "post" do

      assert_select "input#instagram_comment_instagram_post_id[name=?]", "instagram_comment[instagram_post_id]"

      assert_select "input#instagram_comment_instagram_user_id[name=?]", "instagram_comment[instagram_user_id]"

      assert_select "input#instagram_comment_comment[name=?]", "instagram_comment[comment]"
    end
  end
end
