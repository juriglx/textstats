class StatisticsController < ApplicationController
  
  def index
    @statistic = Statistic.new(statistic_params)
  end

  def calculate
    puts params
    redirect_to statistics_path
  end

  private

  def statistic_params
    params.fetch(:statistic, {}).permit(:text, :font_size, :max_width)
  end

end
