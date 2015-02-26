require 'test_helper'

class SellingSurplusConfsControllerTest < ActionController::TestCase
  setup do
    @selling_surplus_conf = selling_surplus_confs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:selling_surplus_confs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create selling_surplus_conf" do
    assert_difference('SellingSurplusConf.count') do
      post :create, :selling_surplus_conf => @selling_surplus_conf.attributes
    end

    assert_redirected_to selling_surplus_conf_path(assigns(:selling_surplus_conf))
  end

  test "should show selling_surplus_conf" do
    get :show, :id => @selling_surplus_conf.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @selling_surplus_conf.to_param
    assert_response :success
  end

  test "should update selling_surplus_conf" do
    put :update, :id => @selling_surplus_conf.to_param, :selling_surplus_conf => @selling_surplus_conf.attributes
    assert_redirected_to selling_surplus_conf_path(assigns(:selling_surplus_conf))
  end

  test "should destroy selling_surplus_conf" do
    assert_difference('SellingSurplusConf.count', -1) do
      delete :destroy, :id => @selling_surplus_conf.to_param
    end

    assert_redirected_to selling_surplus_confs_path
  end
end
