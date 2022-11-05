class GamesController < ApplicationController
  def calculate_new_score(winner_score, loser_score)
    return {winner: 1200, loser: 1200}
  end

  def new
    winner = Score.find(params[:winner])
    loser = Score.find(params[:loser])
    new_scores = calculate_new_score(winner.score, loser.score)
    Score.transaction do
      begin
        winner.update(score: new_scores[:winner], games: winner.games + 1)
        loser.update(score: new_scores[:loser], games: loser.games + 1)
      rescue ActiveRecord::StatementInvalid
      end
    end
    redirect_to root_url
  end
end
