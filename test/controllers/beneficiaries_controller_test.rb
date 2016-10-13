require 'test_helper'

class BeneficiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get beneficiaries_index_url
    assert_response :success
  end

end
