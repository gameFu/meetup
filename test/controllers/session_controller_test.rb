require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest

    test "login with invaild information" do
      user = create(:user, name: 'gamefu')

      get login_path
      post login_path, params: {session: { name: '', password: '' }}
      assert_not current_user
    end

    test "json login with vaild information" do
      # @request.headers['Accept'] = Mime::JSON
      user = create(:user, name: 'gamefu')
      post login_path, params: {session: { name: user.name, password: '123123' } }, headers: { Accept: 'application/json' }, as: :json
    end

    test "login with vaild information" do
      user = create(:user, name: 'gamefu')
      get login_path
      post login_path, params: {session:{ name: user.name, password: '123123' }}
      assert_equal user.id, current_user.id

    end


    test "logout" do
      login_user
      delete logout_path
      assert_not current_user
    end

end
