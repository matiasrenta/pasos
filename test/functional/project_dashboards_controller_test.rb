require 'test_helper'

class ProjectDashboardsControllerTest < ActionController::TestCase
  setup do
    @project_dashboard = project_dashboards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_dashboards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_dashboard" do
    assert_difference('ProjectDashboard.count') do
      post :create, :project_dashboard => @project_dashboard.attributes
    end

    assert_redirected_to project_dashboard_path(assigns(:project_dashboard))
  end

  test "should show project_dashboard" do
    get :show, :id => @project_dashboard.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @project_dashboard.to_param
    assert_response :success
  end

  test "should update project_dashboard" do
    put :update, :id => @project_dashboard.to_param, :project_dashboard => @project_dashboard.attributes
    assert_redirected_to project_dashboard_path(assigns(:project_dashboard))
  end

  test "should destroy project_dashboard" do
    assert_difference('ProjectDashboard.count', -1) do
      delete :destroy, :id => @project_dashboard.to_param
    end

    assert_redirected_to project_dashboards_path
  end
end
