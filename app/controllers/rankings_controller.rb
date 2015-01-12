class RankingsController < ApplicationController
  before_action :authorize_read_rankings

  private
    def authorize_read_rankings
      authorize! :read, :rankings
    end

end
