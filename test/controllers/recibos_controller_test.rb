require 'test_helper'

class RecibosControllerTest < ActionController::TestCase
  setup do
    @recibo = recibos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recibos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recibo" do
    assert_difference('Recibo.count') do
      post :create, recibo: { data: @recibo.data, valor: @recibo.valor, valor_extenso: @recibo.valor_extenso }
    end

    assert_redirected_to recibo_path(assigns(:recibo))
  end

  test "should show recibo" do
    get :show, id: @recibo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recibo
    assert_response :success
  end

  test "should update recibo" do
    patch :update, id: @recibo, recibo: { data: @recibo.data, valor: @recibo.valor, valor_extenso: @recibo.valor_extenso }
    assert_redirected_to recibo_path(assigns(:recibo))
  end

  test "should destroy recibo" do
    assert_difference('Recibo.count', -1) do
      delete :destroy, id: @recibo
    end

    assert_redirected_to recibos_path
  end
end
