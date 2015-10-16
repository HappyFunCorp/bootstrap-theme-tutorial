 
 
class InstagramCommentsController < ApplicationController
  before_action :set_instagram_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @instagram_comments = InstagramComment.all
  end 

  def show
  end 

  def new 
    @instagram_comment = InstagramComment.new
  end 

  def edit
  end 

  def create
    @instagram_comment = InstagramComment.new(instagram_comment_params)
    @instagram_comment.save
    respond_with(@instagram_comment)
  end 

  def update
    @instagram_comment.update(instagram_comment_params)
    flash[:notice] = 'Instagram comment was successfully updated.'
    respond_with(@instagram_comment)
  end 

  def destroy
    @instagram_comment.destroy
    redirect_to instagram_comments_url, notice: 'Instagram comment was successfully destroyed.'
  end 

  private
    def set_instagram_comment
      @instagram_comment = InstagramComment.find(params[:id])
    end 

    def instagram_comment_params
      params.require(:instagram_comment).permit(:instagram_post_id, :instagram_user_id, :comment) 
    end 
end
 
