require 'test_helper'

class FlowerBunchControllerTest < ActionController::TestCase
  test "should get application" do
    get :application
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

end
