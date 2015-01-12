class YoutubeController < ApplicationController
  before_action :ensure_artist
  before_action :refresh_token

  def uploads
    # see: API Reference - https://developers.google.com/youtube/v3/docs/playlistItems
    render text: get_uploads
  end

  private
    def ensure_artist
      @artist = current_user.try(:artist)
      authorize! :manage, @artist
    end

    def refresh_token
      current_user.refresh_token_if_expired
    end

    def get_uploads
      channels_response = youtube_get("channels",
                                    part: "contentDetails",
                                    mine: true)
      channels = JSON.parse(channels_response.body)
      # TODO: upload_list_idはArtist登録時にDBに保存したい
      # このIDは常に変化しない、かつitemsが必ず1要素なら可能
      upload_list_id = channels["items"][0]["contentDetails"]["relatedPlaylists"]["uploads"]
      playlistitems_response = youtube_get("playlistItems",
                                         part: "snippet",
                                         maxResults: 20,
                                         playlistId: upload_list_id)
      playlistitems_response
    end

    def youtube_get(resource_name, parameters = {})
      RestClient.get(
        "https://www.googleapis.com/youtube/v3/#{resource_name}",
        params: parameters,
        Authorization: "Bearer #{current_user.google_token}")
    end

end
