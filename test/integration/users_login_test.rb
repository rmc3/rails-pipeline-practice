require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @valid_user = users(:barbaz)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { username: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with a valid user' do
    get login_path
    post login_path, params: { session: {
      username: @valid_user.username,
      password: 'barbazbarbaz'
    } }
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'welcome/index'
    assert_select 'div.alert-success'
    assert_select 'div#privileged_information'
  end
end
