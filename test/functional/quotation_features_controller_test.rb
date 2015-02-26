require 'test_helper'

class QuotationFeaturesControllerTest < ActionController::TestCase
  setup do
    @quotation_feature = quotation_features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotation_features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quotation_feature" do
    assert_difference('QuotationFeature.count') do
      post :create, :quotation_feature => @quotation_feature.attributes
    end

    assert_redirected_to quotation_feature_path(assigns(:quotation_feature))
  end

  test "should show quotation_feature" do
    get :show, :id => @quotation_feature.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quotation_feature.to_param
    assert_response :success
  end

  test "should update quotation_feature" do
    put :update, :id => @quotation_feature.to_param, :quotation_feature => @quotation_feature.attributes
    assert_redirected_to quotation_feature_path(assigns(:quotation_feature))
  end

  test "should destroy quotation_feature" do
    assert_difference('QuotationFeature.count', -1) do
      delete :destroy, :id => @quotation_feature.to_param
    end

    assert_redirected_to quotation_features_path
  end
end
