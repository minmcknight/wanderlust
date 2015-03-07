require 'test_helper'

class TrailUsersControllerTest < ActionController::TestCase
  setup do
    @trail_user = trail_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trail_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trail_user" do
    assert_difference('TrailUser.count') do
      post :create, trail_user: {  }
    end

    assert_redirected_to trail_user_path(assigns(:trail_user))
  end

  test "should show trail_user" do
    get :show, id: @trail_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trail_user
    assert_response :success
  end

  test "should update trail_user" do
    patch :update, id: @trail_user, trail_user: {  }
    assert_redirected_to trail_user_path(assigns(:trail_user))
  end

  test "should destroy trail_user" do
    assert_difference('TrailUser.count', -1) do
      delete :destroy, id: @trail_user
    end

    assert_redirected_to trail_users_path
  end
end
