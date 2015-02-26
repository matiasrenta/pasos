require 'test_helper'

class CommissionDiscountConfsControllerTest < ActionController::TestCase
  setup do
    @commission_discount_conf = commission_discount_confs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:commission_discount_confs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create commission_discount_conf" do
    assert_difference('CommissionDiscountConf.count') do
      post :create, :commission_discount_conf => @commission_discount_conf.attributes
    end

    assert_redirected_to commission_discount_conf_path(assigns(:commission_discount_conf))
  end

  test "should show commission_discount_conf" do
    get :show, :id => @commission_discount_conf.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @commission_discount_conf.to_param
    assert_response :success
  end

  test "should update commission_discount_conf" do
    put :update, :id => @commission_discount_conf.to_param, :commission_discount_conf => @commission_discount_conf.attributes
    assert_redirected_to commission_discount_conf_path(assigns(:commission_discount_conf))
  end

  test "should destroy commission_discount_conf" do
    assert_difference('CommissionDiscountConf.count', -1) do
      delete :destroy, :id => @commission_discount_conf.to_param
    end

    assert_redirected_to commission_discount_confs_path
  end
end
