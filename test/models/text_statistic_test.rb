require 'test_helper'

class TextStatisticTest < ActiveSupport::TestCase

  # text width values generated with 127.0.0.1:3000/jsmetrics.html
  
  test "should calculate correct width (single line, single whitespace)" do
    statistic = TextStatistic.new(font_name: 'TizenSansRegular', font_size: '20', max_width: '2000', text: 'hello world')
    assert_equal 1, statistic.lines.size
    assert_in_delta 98.07, statistic.lines[0][:width], 0.5
  end

  test "should calculate correct width (single line, double whitespace)" do
    statistic = TextStatistic.new(font_name: 'TizenSansRegular', font_size: '20', max_width: '2000', text: 'hello  world')
    assert_equal 1, statistic.lines.size
    assert_in_delta 103.46, statistic.lines[0][:width], 0.5
  end

  lorem_ipsum = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' \
        ' tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,' \
        ' quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo' \
        ' consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse' \
        ' cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non' \
        ' proident, sunt in culpa qui officia deserunt mollit anim id est laborum.' \

  test "should calculate correct widths (multiline)" do
    statistic = TextStatistic.new(font_name: 'TizenSansRegular', font_size: '20', max_width: '300', text: lorem_ipsum)
    assert_equal 15, statistic.lines.size
    assert_operator 300, :>, statistic.lines.map{ |line| line[:width] }.max
  end 

  test "should break up multiple whitespaces" do
    statistic = TextStatistic.new(font_name: 'TizenSansRegular', font_size: '20', max_width: '100', text: 'a                            a')
    assert_equal 2, statistic.lines.size
  end

  test "should not return empty lines if text is to wide for max_width" do
    statistic = TextStatistic.new(font_name: 'TizenSansRegular', font_size: '20', max_width: '40', text: 'exercitation')
    assert_equal 1, statistic.lines.size
  end 

end
