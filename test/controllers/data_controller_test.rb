require "test_helper"

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get perform" do
    get data_perform_url
    assert_response :success
  end
end
