require 'test_helper'

class FixedTherapiesControllerTest < ActionController::TestCase
  setup do
    @fixed_therapy = fixed_therapies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fixed_therapies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fixed_therapy" do
    assert_difference('FixedTherapy.count') do
      post :create, :fixed_therapy => @fixed_therapy.attributes
    end

    assert_redirected_to fixed_therapy_path(assigns(:fixed_therapy))
  end

  test "should show fixed_therapy" do
    get :show, :id => @fixed_therapy.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fixed_therapy.to_param
    assert_response :success
  end

  test "should update fixed_therapy" do
    put :update, :id => @fixed_therapy.to_param, :fixed_therapy => @fixed_therapy.attributes
    assert_redirected_to fixed_therapy_path(assigns(:fixed_therapy))
  end

  test "should destroy fixed_therapy" do
    assert_difference('FixedTherapy.count', -1) do
      delete :destroy, :id => @fixed_therapy.to_param
    end

    assert_redirected_to fixed_therapies_path
  end
end
