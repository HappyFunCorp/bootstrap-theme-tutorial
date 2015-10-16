 
 
class InstagramPostsController < ApplicationController
  before_action :set_instagram_post, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @instagram_posts = InstagramPost.all
  end 

  def show
  end 

  def new 
    @instagram_post = InstagramPost.new
  end 

  def edit
  end 

  def create
    @instagram_post = InstagramPost.new(instagram_post_params)
    @instagram_post.save
    respond_with(@instagram_post)
  end 

  def update
    @instagram_post.update(instagram_post_params)
    flash[:notice] = 'Instagram post was successfully updated.'
    respond_with(@instagram_post)
  end 

  def destroy
    @instagram_post.destroy
    redirect_to instagram_posts_url, notice: 'Instagram post was successfully destroyed.'
  end 

  private
    def set_instagram_post
      @instagram_post = InstagramPost.find(params[:id])
    end 

    def instagram_post_params
      params.require(:instagram_post).permit(:user_id, :instagram_user_id, :media_id, :media_type, :comments_count, :likes_count, :link, :thumbnail_url, :standard_url) 
    end 
end
 
