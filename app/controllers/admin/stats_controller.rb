class Admin::StatsController < ApplicationController
  before_filter :authenticate_admin_user!

  def stats
    if params[:scope].blank?
      render :json => { :errors => "scope not set" }, :status => 422
    else
      cls = User
      cls = Identity.where( "provider = ?", "twitter" ) if params[:scope] == 'twitter_users'
      cls = InstagramUser if params[:scope] == 'instagram_users'
      cls = Crush if params[:scope] == 'crushes'
      cls = InstagramLike if params[:scope] == 'likes'
      ret = cls.group_by_day
      ret = InstagramComment.group_by_day :updated_at if params[:scope] == 'comments'
      render json: ret
    end
  end
end