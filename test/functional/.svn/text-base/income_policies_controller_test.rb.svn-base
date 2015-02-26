require 'test_helper'

class IncomePoliciesControllerTest < ActionController::TestCase
  setup do
    @income_policy = income_policies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:income_policies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create income_policy" do
    assert_difference('IncomePolicy.count') do
      post :create, :income_policy => @income_policy.attributes
    end

    assert_redirected_to income_policy_path(assigns(:income_policy))
  end

  test "should show income_policy" do
    get :show, :id => @income_policy.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @income_policy.to_param
    assert_response :success
  end

  test "should update income_policy" do
    put :update, :id => @income_policy.to_param, :income_policy => @income_policy.attributes
    assert_redirected_to income_policy_path(assigns(:income_policy))
  end

  test "should destroy income_policy" do
    assert_difference('IncomePolicy.count', -1) do
      delete :destroy, :id => @income_policy.to_param
    end

    assert_redirected_to income_policies_path
  end
end
