require 'test_helper'

class MeetUpsControllerTest < ActionDispatch::IntegrationTest

  test "can't create with user no login " do
    assert_difference 'MeetUp.count', 0 do
       post meet_ups_path, params: {
         meet_up: {content: 'xxxx'}
       }
    end
  end

  test "create" do
    login_user
    assert_difference 'MeetUp.count', 1 do
       post meet_ups_path, params: {
         meet_up: {content: 'xxxx'}
       }
    end
  end

  test "index for json" do
    login_user
    create(:meet_up)
    login_get meet_ups_path, as: :json
    assert_equal response_json[0]['id'], @login_user.id
  end

  test "index for json without login" do
    create(:user)
    create(:meet_up)
    get meet_ups_path, as: :json
    assert_response 403
  end


end
