class InstagramPostsController < ApplicationController
  before_action :require_instagram_token
  before_action :require_fresh_user
  before_action :load_stats, only: [ :stats, :for_user ]
  before_action :set_instagram_post, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @title = "Instagram Feed"
    @instagram_posts = current_user.instagram_user.instagram_posts.all
  end 

  def show
  end 

  def stats
    @title = "Top Users"
    @top_photos = @igu.instagram_posts.order( "likes_count desc" ).limit( 24 )
  end

  def for_user
    @title = "#{params[:username]}'s interaction with #{@igu.username}"
    @top_photos = []

    user = InstagramUser.where( username: params[:username] ).first

    if user.nil?
      flash[:error] = "Couldn't find user #{params[:username]}"
    else
      liked = @igu.instagram_posts.joins( :instagram_likes ).where( instagram_likes: { instagram_user_id: user.id } )
      commented = @igu.instagram_posts.joins( :instagram_comments ).where( instagram_comments: { instagram_user_id: user.id } )

      @top_photos = (liked + commented).uniq do |post|
        post.id
      end.sort do |b,a|
        a.likes_count <=> b.likes_count
      end
    end

    render :stats
  end

  # def new 
  #   @instagram_post = InstagramPost.new
  # end 

  # def edit
  # end 

  # def create
  #   @instagram_post = InstagramPost.new(instagram_post_params)
  #   @instagram_post.save
  #   respond_with(@instagram_post)
  # end 

  # def update
  #   @instagram_post.update(instagram_post_params)
  #   flash[:notice] = 'Instagram post was successfully updated.'
  #   respond_with(@instagram_post)
  # end 

  # def destroy
  #   @instagram_post.destroy
  #   redirect_to instagram_posts_url, notice: 'Instagram post was successfully destroyed.'
  # end 

  private
    def set_instagram_post
      @instagram_post = current_user.instagram_user.instagram_posts.find(params[:id])
    end 

    def instagram_post_params
      params.require(:instagram_post).permit(:instagram_user_id, :media_id, :media_type, :comments_count, :likes_count, :link, :thumbnail_url, :standard_url) 
    end 

    def load_stats
      @igu = current_user.instagram_user
      @top_likers = InstagramLike.top_likers_ids @igu
      @top_comments = InstagramComment.top_commentors_ids @igu
  end
end
 
