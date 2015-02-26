require 'test_helper'

class PressTypesControllerTest < ActionController::TestCase
  setup do
    @press_type = press_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:press_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create press_type" do
    assert_difference('PressType.count') do
      post :create, :press_type => @press_type.attributes
    end

    assert_redirected_to press_type_path(assigns(:press_type))
  end

  test "should show press_type" do
    get :show, :id => @press_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @press_type.to_param
    assert_response :success
  end

  test "should update press_type" do
    put :update, :id => @press_type.to_param, :press_type => @press_type.attributes
    assert_redirected_to press_type_path(assigns(:press_type))
  end

  test "should destroy press_type" do
    assert_difference('PressType.count', -1) do
      delete :destroy, :id => @press_type.to_param
    end

    assert_redirected_to press_types_path
  end
end
