require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  test "create comment" do
    login_user
    meet_up = create(:meet_up)
    assert_difference 'Comment.count', 1 do
      login_post comments_path, params: {
        comment: {
          meet_up_id: meet_up.id,
          content: '好的'
        },
        formats: :html
      }
    end
    assert_equal 1, meet_up.reload.comments.count
  end

  test "can't create comment without login" do
    create(:user)
    meet_up = create(:meet_up)
    assert_difference 'Comment.count', 0 do
      post comments_path, params: {
        comment: {
          meet_up_id: meet_up.id,
          content: '好的'
        },
        formats: :html
      }
    end
  end

end
