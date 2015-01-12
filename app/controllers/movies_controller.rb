class MoviesController < ApplicationController

  load_and_authorize_resource through: :artist,
                            shallow: true,
                            except: [:index]

  def index
    @artist = Artist.find(params[:artist_id])
    @movies = @artist.movies.order(created_at: :desc)
  end

  def show
    @movie.view_count += 1
    @movie.save
    @movies = @movie.artist.movies.order(created_at: :desc).limit(5)
  end

  def new
  end

  def create
    # TODO: youtube_video_idが本当に自分の動画かチェックする
    # 他人の動画IDを指定したらそのまま投稿できるので
    if @movie.save
      flash[:notice] = "動画を投稿しました。"
      redirect_to movie_url(@movie)
    else
      render "new"
    end
  end
  
  def edit
  end

  def update
    if @movie.update(update_params)
      flash[:notice] = I18n.t "helpers.notices.updated", model: Movie.model_name.human
      redirect_to movie_url(@movie)
    else
      render "edit"
    end
  end

  def destroy
    @movie.destroy
      flash[:notice] = I18n.t "helpers.notices.destroyed", model: Movie.model_name.human
    redirect_to my_movies_path
  end

  private
    
    def create_params
      params.require(:movie).permit(:title, :youtube_video_id, :description)
    end

    def update_params
      params.require(:movie).permit(:title, :description)
    end

end
