require 'test_helper'

class LoginControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get login_url
    assert_response :success
    assert_select 'title', 'Login | Pipeline Practice'
  end
end
