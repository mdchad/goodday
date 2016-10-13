require 'test_helper'

class HowControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get how_index_url
    assert_response :success
  end

end
