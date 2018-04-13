require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get root' do
    get root_url
    assert_response :success
    assert_select 'title', 'Pipeline Practice'
  end

  test 'should get index' do
    get welcome_index_url
    assert_response :success
    assert_select 'title', 'Pipeline Practice'
  end
end
