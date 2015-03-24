require 'test_helper'

class CancellationsControllerTest < ActionController::TestCase
  setup do
    @cancellation = cancellations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cancellations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cancellation" do
    assert_difference('Cancellation.count') do
      post :create, :cancellation => @cancellation.attributes
    end

    assert_redirected_to cancellation_path(assigns(:cancellation))
  end

  test "should show cancellation" do
    get :show, :id => @cancellation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cancellation.to_param
    assert_response :success
  end

  test "should update cancellation" do
    put :update, :id => @cancellation.to_param, :cancellation => @cancellation.attributes
    assert_redirected_to cancellation_path(assigns(:cancellation))
  end

  test "should destroy cancellation" do
    assert_difference('Cancellation.count', -1) do
      delete :destroy, :id => @cancellation.to_param
    end

    assert_redirected_to cancellations_path
  end
end
