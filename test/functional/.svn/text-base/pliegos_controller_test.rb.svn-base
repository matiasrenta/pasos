require 'test_helper'

class PliegosControllerTest < ActionController::TestCase
  setup do
    @pliego = pliegos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pliegos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pliego" do
    assert_difference('Pliego.count') do
      post :create, :pliego => @pliego.attributes
    end

    assert_redirected_to pliego_path(assigns(:pliego))
  end

  test "should show pliego" do
    get :show, :id => @pliego.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pliego.to_param
    assert_response :success
  end

  test "should update pliego" do
    put :update, :id => @pliego.to_param, :pliego => @pliego.attributes
    assert_redirected_to pliego_path(assigns(:pliego))
  end

  test "should destroy pliego" do
    assert_difference('Pliego.count', -1) do
      delete :destroy, :id => @pliego.to_param
    end

    assert_redirected_to pliegos_path
  end
end
