class GamesController < ApplicationController
  def k_factor(score, games)
    if games < 30
      return 40
    else
      if score < 2400
        return 20
      else
        return 10
      end
    end
  end

  def expected(winner_score, loser_score)
    return {winner: 1/(1+10**((loser_score-winner_score)/400.to_f)), loser: 1/(1+10**((winner_score-loser_score)/400.to_f))}
  end

  def calculate_new_scores(winner_score, winner_games, loser_score, loser_games)
    winner_k = k_factor(winner_score, winner_games)
    loser_k = k_factor(loser_score, loser_games)
    expected_scores = expected(winner_score, loser_score)
    puts expected_scores
    puts loser_score + loser_k*(1 - expected_scores[:loser])
    return {winner: winner_score + winner_k*(1 - expected_scores[:winner]), loser: loser_score + loser_k*(0 - expected_scores[:loser])}
  end

  def new
    winner = Score.find(params[:winner])
    loser = Score.find(params[:loser])
    new_scores = calculate_new_scores(winner.score, winner.games, loser.score, loser.games)
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
