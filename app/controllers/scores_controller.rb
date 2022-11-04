class ScoresController < ApplicationController
  def ranking
    @scores = Score.order(:score)
  end
end
