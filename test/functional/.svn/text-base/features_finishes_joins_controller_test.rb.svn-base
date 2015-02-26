require 'test_helper'

class FeaturesFinishesJoinsControllerTest < ActionController::TestCase
  setup do
    @features_finishes_join = features_finishes_joins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:features_finishes_joins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create features_finishes_join" do
    assert_difference('FeaturesFinishesJoin.count') do
      post :create, :features_finishes_join => @features_finishes_join.attributes
    end

    assert_redirected_to features_finishes_join_path(assigns(:features_finishes_join))
  end

  test "should show features_finishes_join" do
    get :show, :id => @features_finishes_join.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @features_finishes_join.to_param
    assert_response :success
  end

  test "should update features_finishes_join" do
    put :update, :id => @features_finishes_join.to_param, :features_finishes_join => @features_finishes_join.attributes
    assert_redirected_to features_finishes_join_path(assigns(:features_finishes_join))
  end

  test "should destroy features_finishes_join" do
    assert_difference('FeaturesFinishesJoin.count', -1) do
      delete :destroy, :id => @features_finishes_join.to_param
    end

    assert_redirected_to features_finishes_joins_path
  end
end
