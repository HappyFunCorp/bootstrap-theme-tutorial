require 'rails_helper'

RSpec.describe "instagram_comments/show", type: :view do
  before(:each) do
    @instagram_comment = assign(:instagram_comment, InstagramComment.create!(
      :instagram_post_id => 1,
      :instagram_user_id => 2,
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Comment/)
  end
end
