class Movies::RankingsController < RankingsController

  def view
    @movies = Movie.order(view_count: :desc).limit(30)
  end

end
