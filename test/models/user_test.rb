require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'user encode jwt' do
    user = create(:user)
    user_jwt = user.to_jwt
    decode = JWT.decode user_jwt, Rails.application.secrets['jwt_secret'], Rails.application.secrets['jwt_algorithm']
    assert_equal user.id, decode[0]['user']['user_id']
  end

end
