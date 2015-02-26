require 'test_helper'

class ImplementationsControllerTest < ActionController::TestCase
  setup do
    @implementation = implementations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:implementations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create implementation" do
    assert_difference('Implementation.count') do
      post :create, :implementation => @implementation.attributes
    end

    assert_redirected_to implementation_path(assigns(:implementation))
  end

  test "should show implementation" do
    get :show, :id => @implementation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @implementation.to_param
    assert_response :success
  end

  test "should update implementation" do
    put :update, :id => @implementation.to_param, :implementation => @implementation.attributes
    assert_redirected_to implementation_path(assigns(:implementation))
  end

  test "should destroy implementation" do
    assert_difference('Implementation.count', -1) do
      delete :destroy, :id => @implementation.to_param
    end

    assert_redirected_to implementations_path
  end
end
