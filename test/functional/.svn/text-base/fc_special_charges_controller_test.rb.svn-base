require 'test_helper'

class FcSpecialChargesControllerTest < ActionController::TestCase
  setup do
    @fc_special_charge = fc_special_charges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fc_special_charges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fc_special_charge" do
    assert_difference('FcSpecialCharge.count') do
      post :create, :fc_special_charge => @fc_special_charge.attributes
    end

    assert_redirected_to fc_special_charge_path(assigns(:fc_special_charge))
  end

  test "should show fc_special_charge" do
    get :show, :id => @fc_special_charge.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fc_special_charge.to_param
    assert_response :success
  end

  test "should update fc_special_charge" do
    put :update, :id => @fc_special_charge.to_param, :fc_special_charge => @fc_special_charge.attributes
    assert_redirected_to fc_special_charge_path(assigns(:fc_special_charge))
  end

  test "should destroy fc_special_charge" do
    assert_difference('FcSpecialCharge.count', -1) do
      delete :destroy, :id => @fc_special_charge.to_param
    end

    assert_redirected_to fc_special_charges_path
  end
end
