require 'test_helper'

class UsersControllerTest <  ActionController::TestCase

  test "create" do
    assert_difference 'User.count', 1 do
      post :create, params: {
        user: {
          name: 'gamefu',
          password: '123123',
          password_confirmation: '123123'
        }
      }
    end
  end

end
