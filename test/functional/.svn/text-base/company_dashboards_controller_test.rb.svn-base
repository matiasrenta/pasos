require 'test_helper'

class CompanyDashboardsControllerTest < ActionController::TestCase
  setup do
    @company_dashboard = company_dashboards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_dashboards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_dashboard" do
    assert_difference('CompanyDashboard.count') do
      post :create, :company_dashboard => @company_dashboard.attributes
    end

    assert_redirected_to company_dashboard_path(assigns(:company_dashboard))
  end

  test "should show company_dashboard" do
    get :show, :id => @company_dashboard.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @company_dashboard.to_param
    assert_response :success
  end

  test "should update company_dashboard" do
    put :update, :id => @company_dashboard.to_param, :company_dashboard => @company_dashboard.attributes
    assert_redirected_to company_dashboard_path(assigns(:company_dashboard))
  end

  test "should destroy company_dashboard" do
    assert_difference('CompanyDashboard.count', -1) do
      delete :destroy, :id => @company_dashboard.to_param
    end

    assert_redirected_to company_dashboards_path
  end
end
