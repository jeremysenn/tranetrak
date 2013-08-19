require 'test_helper'

class ExerciseSessionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => ExerciseSession.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    ExerciseSession.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    ExerciseSession.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to exercise_session_url(assigns(:exercise_session))
  end

  def test_edit
    get :edit, :id => ExerciseSession.first
    assert_template 'edit'
  end

  def test_update_invalid
    ExerciseSession.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ExerciseSession.first
    assert_template 'edit'
  end

  def test_update_valid
    ExerciseSession.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ExerciseSession.first
    assert_redirected_to exercise_session_url(assigns(:exercise_session))
  end

  def test_destroy
    exercise_session = ExerciseSession.first
    delete :destroy, :id => exercise_session
    assert_redirected_to exercise_sessions_url
    assert !ExerciseSession.exists?(exercise_session.id)
  end
end
