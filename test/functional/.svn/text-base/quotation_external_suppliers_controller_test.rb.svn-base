require 'test_helper'

class QuotationExternalSuppliersControllerTest < ActionController::TestCase
  setup do
    @quotation_external_supplier = quotation_external_suppliers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quotation_external_suppliers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quotation_external_supplier" do
    assert_difference('QuotationExternalSupplier.count') do
      post :create, :quotation_external_supplier => @quotation_external_supplier.attributes
    end

    assert_redirected_to quotation_external_supplier_path(assigns(:quotation_external_supplier))
  end

  test "should show quotation_external_supplier" do
    get :show, :id => @quotation_external_supplier.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quotation_external_supplier.to_param
    assert_response :success
  end

  test "should update quotation_external_supplier" do
    put :update, :id => @quotation_external_supplier.to_param, :quotation_external_supplier => @quotation_external_supplier.attributes
    assert_redirected_to quotation_external_supplier_path(assigns(:quotation_external_supplier))
  end

  test "should destroy quotation_external_supplier" do
    assert_difference('QuotationExternalSupplier.count', -1) do
      delete :destroy, :id => @quotation_external_supplier.to_param
    end

    assert_redirected_to quotation_external_suppliers_path
  end
end
