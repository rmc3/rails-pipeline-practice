require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'foo', password: 'foobarfoobar', password_confirmation: 'foobarfoobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.username = '    '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.username = 'a' * 100
    assert_not @user.valid?
  end

  test 'name should not be too short' do
    @user.username = 'aa'
    assert_not @user.valid?
  end

  test 'usernames should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'usernames should be unique regardless of case' do
    duplicate_user = @user.dup
    duplicate_user.username = @user.username.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'all usernames should be downcased in the database' do
    mixed_case_username = 'Bar'
    @user.username = mixed_case_username
    @user.save
    retrieved = User.where(username: mixed_case_username.downcase).take
    assert retrieved.username == mixed_case_username.downcase
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 8
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 7
    assert_not @user.valid?
  end
end
