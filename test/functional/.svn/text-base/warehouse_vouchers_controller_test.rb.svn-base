require 'test_helper'

class WarehouseVouchersControllerTest < ActionController::TestCase
  setup do
    @warehouse_voucher = warehouse_vouchers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warehouse_vouchers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warehouse_voucher" do
    assert_difference('WarehouseVoucher.count') do
      post :create, :warehouse_voucher => @warehouse_voucher.attributes
    end

    assert_redirected_to warehouse_voucher_path(assigns(:warehouse_voucher))
  end

  test "should show warehouse_voucher" do
    get :show, :id => @warehouse_voucher.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @warehouse_voucher.to_param
    assert_response :success
  end

  test "should update warehouse_voucher" do
    put :update, :id => @warehouse_voucher.to_param, :warehouse_voucher => @warehouse_voucher.attributes
    assert_redirected_to warehouse_voucher_path(assigns(:warehouse_voucher))
  end

  test "should destroy warehouse_voucher" do
    assert_difference('WarehouseVoucher.count', -1) do
      delete :destroy, :id => @warehouse_voucher.to_param
    end

    assert_redirected_to warehouse_vouchers_path
  end
end
