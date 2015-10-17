class WelcomeController < ApplicationController
  def landing
    redirect_to crushes_path if current_user
  end

  def show_feed
  end

  def loading_crush
  end

  def show_crush
  end

  def friends
  end

  def frenemies
  end

  def fans
  end

  def stars
  end
end
