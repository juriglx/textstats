class StatisticsController < ApplicationController
  
  def index
    unless statistic_params.empty?
      @statistic = TextStatistic.new(statistic_params)
      @lines = @statistic.lines if @statistic.valid?
    else
      @statistic = TextStatistic.new
    end
  end

  private

  def statistic_params
    params.fetch(:text_statistic, {}).permit(:text, :font_name, :font_size, :max_width)
  end

end
