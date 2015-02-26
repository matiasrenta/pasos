require 'test_helper'

class QuotationStatesControllerTest < ActionController::TestCase
  setup do
    @quotation_state = quotation_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotation_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quotation_state" do
    assert_difference('QuotationState.count') do
      post :create, :quotation_state => @quotation_state.attributes
    end

    assert_redirected_to quotation_state_path(assigns(:quotation_state))
  end

  test "should show quotation_state" do
    get :show, :id => @quotation_state.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quotation_state.to_param
    assert_response :success
  end

  test "should update quotation_state" do
    put :update, :id => @quotation_state.to_param, :quotation_state => @quotation_state.attributes
    assert_redirected_to quotation_state_path(assigns(:quotation_state))
  end

  test "should destroy quotation_state" do
    assert_difference('QuotationState.count', -1) do
      delete :destroy, :id => @quotation_state.to_param
    end

    assert_redirected_to quotation_states_path
  end
end
