 
 
class InstagramLikesController < ApplicationController
  before_action :set_instagram_like, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @instagram_likes = InstagramLike.all
  end 

  def show
  end 

  def new 
    @instagram_like = InstagramLike.new
  end 

  def edit
  end 

  def create
    @instagram_like = InstagramLike.new(instagram_like_params)
    @instagram_like.save
    respond_with(@instagram_like)
  end 

  def update
    @instagram_like.update(instagram_like_params)
    flash[:notice] = 'Instagram like was successfully updated.'
    respond_with(@instagram_like)
  end 

  def destroy
    @instagram_like.destroy
    redirect_to instagram_likes_url, notice: 'Instagram like was successfully destroyed.'
  end 

  private
    def set_instagram_like
      @instagram_like = InstagramLike.find(params[:id])
    end 

    def instagram_like_params
      params.require(:instagram_like).permit(:instagram_post_id, :instagram_user_id) 
    end 
end
 
