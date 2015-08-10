class Statistic
  include ActiveModel::Model
  attr_accessor :text, :font_size, :max_width

  FONT_PATHS = {
    tizen_sans_regular: 'lib/assets/fonts/TizenSansRegular.ttf'
  }

  def font_family
    :tizen_sans_regular
  end

  def values
    return [] if text.blank?
    @calculated_values ||= calculate_statistics
  end  

  def calculated?
    !values.empty?
  end

  private

  def calculate_statistics
    font = Font.new(FONT_PATHS[font_family])

    token = text.scan(/\S+|\s+/)

    lines = []
    line_width = 0.0
    lines_index = 0

    token.each do |t|
      width = Statistic::text_width(font, t, font_size)

      if (line_width + width) > max_width.to_f
        lines_index = lines_index + 1
        line_width = 0
      end

      line_width = line_width + width

      lines[lines_index] = {
        line: (lines[lines_index].try(:[], :line) || '') + t, 
        width: (lines[lines_index].try(:[], :width) || 0.0) + width
      }
    end

    @calculated_values = lines
  end

  def self.text_width(font, text, font_size)
    font.width_of(text) * font_size.to_f
  end

end
