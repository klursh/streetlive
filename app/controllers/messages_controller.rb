class MessagesController < ApplicationController

  before_action :set_artist

  load_and_authorize_resource through: :artist,
                            shallow: true,
                            except: [:index]
  
  def index
    @messages = @artist.messages.order(created_at: :desc)
  end

  def new
    @message.artist = @artist
  end

  def create
    @message.artist = @artist
    if @message.save
      flash[:notice] = "メッセージを送信しました。"
      redirect_to artist_messages_url(@message.artist)
    else
      render "new"
    end
  end

  private
    def message_params
      params.require(:message).permit(:content, :responds_to)
    end

    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

end
