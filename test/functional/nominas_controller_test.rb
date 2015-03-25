require 'test_helper'

class NominasControllerTest < ActionController::TestCase
  setup do
    @nomina = nominas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nominas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nomina" do
    assert_difference('Nomina.count') do
      post :create, :nomina => @nomina.attributes
    end

    assert_redirected_to nomina_path(assigns(:nomina))
  end

  test "should show nomina" do
    get :show, :id => @nomina.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @nomina.to_param
    assert_response :success
  end

  test "should update nomina" do
    put :update, :id => @nomina.to_param, :nomina => @nomina.attributes
    assert_redirected_to nomina_path(assigns(:nomina))
  end

  test "should destroy nomina" do
    assert_difference('Nomina.count', -1) do
      delete :destroy, :id => @nomina.to_param
    end

    assert_redirected_to nominas_path
  end
end
