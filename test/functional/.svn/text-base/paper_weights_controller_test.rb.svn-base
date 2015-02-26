require 'test_helper'

class PaperWeightsControllerTest < ActionController::TestCase
  setup do
    @paper_weight = paper_weights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paper_weights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paper_weight" do
    assert_difference('PaperWeight.count') do
      post :create, :paper_weight => @paper_weight.attributes
    end

    assert_redirected_to paper_weight_path(assigns(:paper_weight))
  end

  test "should show paper_weight" do
    get :show, :id => @paper_weight.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @paper_weight.to_param
    assert_response :success
  end

  test "should update paper_weight" do
    put :update, :id => @paper_weight.to_param, :paper_weight => @paper_weight.attributes
    assert_redirected_to paper_weight_path(assigns(:paper_weight))
  end

  test "should destroy paper_weight" do
    assert_difference('PaperWeight.count', -1) do
      delete :destroy, :id => @paper_weight.to_param
    end

    assert_redirected_to paper_weights_path
  end
end
