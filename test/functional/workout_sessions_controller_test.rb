require 'test_helper'

class WorkoutSessionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => WorkoutSession.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    WorkoutSession.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    WorkoutSession.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to workout_session_url(assigns(:workout_session))
  end

  def test_edit
    get :edit, :id => WorkoutSession.first
    assert_template 'edit'
  end

  def test_update_invalid
    WorkoutSession.any_instance.stubs(:valid?).returns(false)
    put :update, :id => WorkoutSession.first
    assert_template 'edit'
  end

  def test_update_valid
    WorkoutSession.any_instance.stubs(:valid?).returns(true)
    put :update, :id => WorkoutSession.first
    assert_redirected_to workout_session_url(assigns(:workout_session))
  end

  def test_destroy
    workout_session = WorkoutSession.first
    delete :destroy, :id => workout_session
    assert_redirected_to workout_sessions_url
    assert !WorkoutSession.exists?(workout_session.id)
  end
end
