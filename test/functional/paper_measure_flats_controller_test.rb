require 'test_helper'

class PaperMeasureFlatsControllerTest < ActionController::TestCase
  setup do
    @paper_measure_flat = paper_measure_flats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paper_measure_flats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paper_measure_flat" do
    assert_difference('PaperMeasureFlat.count') do
      post :create, :paper_measure_flat => @paper_measure_flat.attributes
    end

    assert_redirected_to paper_measure_flat_path(assigns(:paper_measure_flat))
  end

  test "should show paper_measure_flat" do
    get :show, :id => @paper_measure_flat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @paper_measure_flat.to_param
    assert_response :success
  end

  test "should update paper_measure_flat" do
    put :update, :id => @paper_measure_flat.to_param, :paper_measure_flat => @paper_measure_flat.attributes
    assert_redirected_to paper_measure_flat_path(assigns(:paper_measure_flat))
  end

  test "should destroy paper_measure_flat" do
    assert_difference('PaperMeasureFlat.count', -1) do
      delete :destroy, :id => @paper_measure_flat.to_param
    end

    assert_redirected_to paper_measure_flats_path
  end
end
