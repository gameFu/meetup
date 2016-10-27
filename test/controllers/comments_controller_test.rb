require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  test "create comment" do
    login_user
    meet_up = create(:meet_up)
    assert_difference 'Comment.count', 1 do
      post :create, params: {
        comment: {
          meet_up_id: meet_up.id,
          content: '好的'
        },
        formats: :html
      }
    end
    assert_equal 1, meet_up.reload.comments.count
  end

end
