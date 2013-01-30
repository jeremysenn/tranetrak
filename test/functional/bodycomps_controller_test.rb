require 'test_helper'

class BodycompsControllerTest < ActionController::TestCase
  setup do
    @bodycomp = bodycomps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bodycomps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bodycomp" do
    assert_difference('Bodycomp.count') do
      post :create, bodycomp: @bodycomp.attributes
    end

    assert_redirected_to bodycomp_path(assigns(:bodycomp))
  end

  test "should show bodycomp" do
    get :show, id: @bodycomp.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bodycomp.to_param
    assert_response :success
  end

  test "should update bodycomp" do
    put :update, id: @bodycomp.to_param, bodycomp: @bodycomp.attributes
    assert_redirected_to bodycomp_path(assigns(:bodycomp))
  end

  test "should destroy bodycomp" do
    assert_difference('Bodycomp.count', -1) do
      delete :destroy, id: @bodycomp.to_param
    end

    assert_redirected_to bodycomps_path
  end
end
