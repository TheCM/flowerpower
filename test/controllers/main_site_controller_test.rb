require 'test_helper'

class MainSiteControllerTest < ActionController::TestCase
  test "should get main_site" do
    get :main_site
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
