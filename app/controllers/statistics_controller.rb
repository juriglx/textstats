class StatisticsController < ApplicationController
  
  def index
    @statistic = TextStatistic.new(statistic_params)

    if @statistic.valid?
      @lines = @statistic.lines 
    end
  end

  private

  def statistic_params
    params.fetch(:text_statistic, {}).permit(:text, :font_name, :font_size, :max_width)
  end

end
