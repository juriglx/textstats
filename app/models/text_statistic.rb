# calculates widths of a text with a given font and font_size
class TextStatistic
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :text, :font_name, :font_size, :max_width
  validates :text, :font_name, :font_size, :max_width, presence: true
  validates :font_name, inclusion: $fonts.keys
  validates :font_size, :max_width, numericality: true

  def initialize(attributes = {})
    super
    @font = $fonts[@font_name]
  end

  def width
    string_width(@text)
  end

  # returns an array of lines/widths, where each line is limited by max_width
  def lines
    lines = [{line: '', width: 0.0}]
    current_line = lines.last

    tokens.each do |token|
      width = string_width(token)

      if (current_line[:width] + width) > @max_width.to_f
        lines << {line: '', width: 0.0}
        current_line = lines.last
      end

      current_line[:line] = current_line[:line] + token
      current_line[:width] = current_line[:width] + width
    end

    lines
  end

  private

  def tokens
    @tokens ||= @text.scan(/\S+|\s/)
  end

  def string_width(string)
    string.split('').map{|char| char_width( char )}.inject{|sum, x| sum + x}
  end

  # returns total width of a char scaled with the font size
  def char_width(char)
    width_in_units = @font.horizontal_metrics.for(glyph_id(char)).advance_width
    (width_in_units.to_f / @font.header.units_per_em) * @font_size.to_f
  end

  def glyph_id(char)
    character_code = char.unpack("U*").first
    @font.cmap.unicode.first[character_code]
  end

end
