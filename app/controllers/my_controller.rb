class MyController < ApplicationController
  
  before_action :ensure_logged_in

  def top
    return redirect_to my_artist_url if current_user.artist
    return redirect_to my_scout_url  if current_user.scout
    return redirect_to my_info_url
  end
  
  def info
  end
  
  def artist
    @artist = current_user.artist
    return redirect_to my_info_path unless @artist
  end

  def scout
    @scout = current_user.scout
    return redirect_to my_info_path unless @scout
    @movies = Movie.order(created_at: :desc).limit(15)
  end

  def movies
    @artist = current_user.artist
    return redirect_to my_info_path unless current_user.artist
    @movies = @artist.movies.order(created_at: :desc)
  end

  private
    def ensure_logged_in
      authorize! :manage, current_user
    end
end
