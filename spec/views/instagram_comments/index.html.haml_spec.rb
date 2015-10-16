require 'rails_helper'

RSpec.describe "instagram_comments/index", type: :view do
  before(:each) do
    assign(:instagram_comments, [
      InstagramComment.create!(
        :instagram_post_id => 1,
        :instagram_user_id => 2,
        :comment => "Comment"
      ),
      InstagramComment.create!(
        :instagram_post_id => 1,
        :instagram_user_id => 2,
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of instagram_comments" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
