require 'test_helper'

class ProductionOrdersControllerTest < ActionController::TestCase
  setup do
    @production_order = production_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:production_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create production_order" do
    assert_difference('ProductionOrder.count') do
      post :create, :production_order => @production_order.attributes
    end

    assert_redirected_to production_order_path(assigns(:production_order))
  end

  test "should show production_order" do
    get :show, :id => @production_order.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @production_order.to_param
    assert_response :success
  end

  test "should update production_order" do
    put :update, :id => @production_order.to_param, :production_order => @production_order.attributes
    assert_redirected_to production_order_path(assigns(:production_order))
  end

  test "should destroy production_order" do
    assert_difference('ProductionOrder.count', -1) do
      delete :destroy, :id => @production_order.to_param
    end

    assert_redirected_to production_orders_path
  end
end
