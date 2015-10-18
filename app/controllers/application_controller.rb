class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate
  before_filter :metatags

  def metatags
    set_meta_tags description: "See who has an instagram crush on you!"
    set_meta_tags og: {
      title:    'Instacrush',
      type:     'website',
      url:      'http://instacrush.happyfuncorp.com',
    }

    set_meta_tags twitter: {
      card: "Instacrush",
      site: "@HappyFunCorp"
    }
  end

  def authenticate
    unless ENV['HTTP_AUTH_USERNAME'].blank? or ENV['HTTP_AUTH_PASSWORD'].blank?
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['HTTP_AUTH_USERNAME'] && password == ENV['HTTP_AUTH_PASSWORD']
      end
    end
  end

  def require_instagram_token
    if current_user.nil? || current_user.instagram.nil?
      store_location_for( :user, request.path )
      redirect_to user_omniauth_authorize_path( :instagram )
      return false
    end
  end

  def require_instagram_user
    if current_user.nil? || current_user.instagram.nil?
      store_location_for( :user, request.path )
      redirect_to user_omniauth_authorize_path( :instagram )
      return false
    elsif current_user.instagram_user.nil?
      redirect_to load_crush_path
      return false
    end
  end
end
