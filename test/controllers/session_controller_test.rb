require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest

    test "login with invaild information" do
      user = create(:user, name: 'gamefu')

      get login_path
      post login_path, params: {session: { name: '', password: '' }}
      assert_not current_user
    end

    test "login with vaild information" do
      user = create(:user, name: 'gamefu')
      get login_path
      post login_path, params: {session:{ name: user.name, password: '123123' }}
      assert_equal user.id, current_user.id

    end

end
