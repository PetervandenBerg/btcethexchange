require 'test_helper'

class GamblesControllerTest < ActionController::TestCase
  setup do
    @gamble = gambles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gambles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gamble" do
    assert_difference('Gamble.count') do
      post :create, gamble: { amount: @gamble.amount, currency_type: @gamble.currency_type, user_id: @gamble.user_id, won: @gamble.won }
    end

    assert_redirected_to gamble_path(assigns(:gamble))
  end

  test "should show gamble" do
    get :show, id: @gamble
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gamble
    assert_response :success
  end

  test "should update gamble" do
    patch :update, id: @gamble, gamble: { amount: @gamble.amount, currency_type: @gamble.currency_type, user_id: @gamble.user_id, won: @gamble.won }
    assert_redirected_to gamble_path(assigns(:gamble))
  end

  test "should destroy gamble" do
    assert_difference('Gamble.count', -1) do
      delete :destroy, id: @gamble
    end

    assert_redirected_to gambles_path
  end
end
