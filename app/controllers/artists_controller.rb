class ArtistsController < ApplicationController
  load_and_authorize_resource

  def show
    @artist.view_count += 1
    @artist.save
    @movies = @artist.movies.order(created_at: :desc).limit(9)
    @messages = @artist.messages.order(created_at: :desc).limit(5)
  end

  def new
    @artist.name = current_user.name
    @artist.email = current_user.email
  end

  def create
    @artist.image = current_user.image
    if @artist.save
      current_user.artist = @artist
      current_user.save
      flash[:notice] = "アーティスト登録しました。"
      redirect_to my_artist_url(@artist)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @artist.update(artist_params)
      flash[:notice] = I18n.t "helpers.notices.updated", model: Artist.model_name.human
      redirect_to artist_url(@artist)
    else
      render "edit"
    end
  end

  def destroy
    @artist.destroy
    flash[:notice] = I18n.t "helpers.notices.destroyed", model: Artist.model_name.human
    redirect_to my_top_url
  end

  private
    def artist_params
      params.require(:artist).permit([:name, :location, :introduction, :email])
    end
end
