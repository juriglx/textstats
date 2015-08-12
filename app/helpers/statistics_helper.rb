module StatisticsHelper

  def pixel_width(pixels)
    "#{number_with_precision(pixels, precision: 2)}px"
  end

end
