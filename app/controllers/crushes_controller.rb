class CrushesController < ApplicationController
  layout "boo" if ENV['BOO']
  
  before_action :require_instagram_token, only: :index
  before_action :set_crush, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    if current_user.stale?
      current_user.sync!
      flash[:notice] = "We've spoken to instagram!"
    end

    redirect_to current_user.crush
  end 

  def show
    if @crush.nil?
      redirect_to root_path, flash: { error: "Couldn't find that crush!" }
      return
    end

    @title = "#{@crush.instagram_user.username}'s crush"

    set_meta_tags description: "Looks like #{@crush.crush_username} has a crush on #{@crush.main_username}.  See who has an instagram crush on you!"

    set_meta_tags og: {
      title:    "#{@crush.instagram_user.username}'s crush",
      description: "Click on this link to see who your secret crush is on Instagram",
      type:     'website',
      url:      "http://instacrush.happyfuncorp.com#{crush_path(@crush)}",
      image:    { _: @crush.image_path, width: 600, height: 315 }
    }
  end 

  private
    def set_crush
      @crush = Crush.where( slug: params[:slug] ).first
    end 

    def crush_params
      params.require(:crush).permit(:user_id, :instagram_user_id, :crush_user_id) 
    end 
end
 
