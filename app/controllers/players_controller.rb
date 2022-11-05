class PlayersController < ApplicationController
  def new
    player = Score.new
    player.name = params[:new_player]
    player.games = 0
    player.score = 1200
    if player.save
      redirect_to root_url
    end
  end
end
