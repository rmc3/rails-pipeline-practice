require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  include ActiveSupport::Testing::Assertions
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username:  '',
                                         email: 'user@invalid',
                                         password: 'foo',
                                         password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: { username: 'foobarfoobar',
                                         password: 'foobarfoobar',
                                         password_confirmation: 'foobarfoobar' } }
    end
    follow_redirect!
    assert_template 'sessions/new'
    assert_select 'div.alert-success'
  end
end
