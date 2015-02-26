require 'test_helper'

class CoatingsControllerTest < ActionController::TestCase
  setup do
    @coating = coatings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coatings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coating" do
    assert_difference('Coating.count') do
      post :create, :coating => @coating.attributes
    end

    assert_redirected_to coating_path(assigns(:coating))
  end

  test "should show coating" do
    get :show, :id => @coating.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @coating.to_param
    assert_response :success
  end

  test "should update coating" do
    put :update, :id => @coating.to_param, :coating => @coating.attributes
    assert_redirected_to coating_path(assigns(:coating))
  end

  test "should destroy coating" do
    assert_difference('Coating.count', -1) do
      delete :destroy, :id => @coating.to_param
    end

    assert_redirected_to coatings_path
  end
end
