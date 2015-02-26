require 'test_helper'

class PaperMeasuresControllerTest < ActionController::TestCase
  setup do
    @paper_measure = paper_measures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paper_measures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paper_measure" do
    assert_difference('PaperMeasure.count') do
      post :create, :paper_measure => @paper_measure.attributes
    end

    assert_redirected_to paper_measure_path(assigns(:paper_measure))
  end

  test "should show paper_measure" do
    get :show, :id => @paper_measure.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @paper_measure.to_param
    assert_response :success
  end

  test "should update paper_measure" do
    put :update, :id => @paper_measure.to_param, :paper_measure => @paper_measure.attributes
    assert_redirected_to paper_measure_path(assigns(:paper_measure))
  end

  test "should destroy paper_measure" do
    assert_difference('PaperMeasure.count', -1) do
      delete :destroy, :id => @paper_measure.to_param
    end

    assert_redirected_to paper_measures_path
  end
end
