class ExerciseSessionsController < ApplicationController
  def index
    @exercise_sessions = ExerciseSession.all
  end

  def show
    @exercise_session = ExerciseSession.find(params[:id])
  end

  def new
    @exercise_session = ExerciseSession.new
  end

  def create
    @exercise_session = ExerciseSession.new(params[:exercise_session])
    @exercise_session.exercise = Exercise.find_or_create_by_name(:name => params[:exercise_session][:exercise_name])
    if @exercise_session.save
      redirect_to @exercise_session, :notice => "Successfully created exercise session."
    else
      render :action => 'new'
    end
  end

  def edit
    @exercise_session = ExerciseSession.find(params[:id])
  end

  def update
    @exercise_session = ExerciseSession.find(params[:id])
    @exercise_session.exercise = Exercise.find_or_create_by_name(:name => params[:exercise_session][:exercise_name])
    if @exercise_session.update_attributes(params[:exercise_session])
      redirect_to @exercise_session, :notice  => "Successfully updated exercise session."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @exercise_session = ExerciseSession.find(params[:id])
    @exercise_session.destroy
    redirect_to exercise_sessions_url, :notice => "Successfully destroyed exercise session."
  end
end
