require 'rails_helper'

RSpec.describe "instagram_likes/show", type: :view do
  before(:each) do
    @instagram_like = assign(:instagram_like, InstagramLike.create!(
      :instagram_post_id => 1,
      :instagram_user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
