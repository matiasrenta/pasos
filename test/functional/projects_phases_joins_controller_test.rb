require 'test_helper'

class ProjectsPhasesJoinsControllerTest < ActionController::TestCase
  setup do
    @projects_phases_join = projects_phases_joins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects_phases_joins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create projects_phases_join" do
    assert_difference('ProjectsPhasesJoin.count') do
      post :create, :projects_phases_join => @projects_phases_join.attributes
    end

    assert_redirected_to projects_phases_join_path(assigns(:projects_phases_join))
  end

  test "should show projects_phases_join" do
    get :show, :id => @projects_phases_join.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @projects_phases_join.to_param
    assert_response :success
  end

  test "should update projects_phases_join" do
    put :update, :id => @projects_phases_join.to_param, :projects_phases_join => @projects_phases_join.attributes
    assert_redirected_to projects_phases_join_path(assigns(:projects_phases_join))
  end

  test "should destroy projects_phases_join" do
    assert_difference('ProjectsPhasesJoin.count', -1) do
      delete :destroy, :id => @projects_phases_join.to_param
    end

    assert_redirected_to projects_phases_joins_path
  end
end
