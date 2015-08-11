require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should calculate response with params" do
    get :index, {text_statistic: {font_name: 'TizenSansRegular', font_size: '10', max_width: '200', text: 'hello world'}}
    assert_response :success
    assert_equal 1, assigns(:lines).size
    assert_equal 'hello world', assigns(:lines)[0][:line]
    assert_in_delta 49.0, assigns(:lines)[0][:width], 0.5
  end

  test "should do nothing if params are missing" do
    get :index, {text_statistic: {font_name: 'TizenSansRegular', font_size: '10', max_width: '200', text: ''}}
    assert_response :success
    assert_nil assigns(:lines)
  end

  test "should do nothing if params have wrong type" do
    get :index, {text_statistic: {font_name: 'TizenSansRegular', font_size: 'pixels', max_width: '200', text: 'hello world'}}
    assert_response :success
    assert_nil assigns(:lines)
  end

end
