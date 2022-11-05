class ScoresController < ApplicationController
  def ranking
    @scores = Score.order(score: :desc)
  end
end
