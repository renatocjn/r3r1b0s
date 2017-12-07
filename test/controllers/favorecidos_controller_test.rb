require 'test_helper'

class FavorecidosControllerTest < ActionController::TestCase
  setup do
    @favorecido = favorecidos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:favorecidos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create favorecido" do
    assert_difference('Favorecido.count') do
      post :create, favorecido: { cpf_cnpj: @favorecido.cpf_cnpj, rg: @favorecido.rg }
    end

    assert_redirected_to favorecido_path(assigns(:favorecido))
  end

  test "should show favorecido" do
    get :show, id: @favorecido
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @favorecido
    assert_response :success
  end

  test "should update favorecido" do
    patch :update, id: @favorecido, favorecido: { cpf_cnpj: @favorecido.cpf_cnpj, rg: @favorecido.rg }
    assert_redirected_to favorecido_path(assigns(:favorecido))
  end

  test "should destroy favorecido" do
    assert_difference('Favorecido.count', -1) do
      delete :destroy, id: @favorecido
    end

    assert_redirected_to favorecidos_path
  end
end
