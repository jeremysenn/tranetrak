class WorkoutSessionsController < ApplicationController
  load_and_authorize_resource

  def index
#    @workout_sessions = WorkoutSession.all
    @workout_sessions = current_user.trainer.workout_sessions if current_user.is_trainer?
    @workout_sessions = current_user.client.workout_sessions if current_user.is_client?
  end

  def show
    @workout_session = WorkoutSession.find(params[:id])
  end

  def new
    @workout_session = WorkoutSession.new
    @workout_session.exercise_sessions.build
    @workout_session.date = Date.today
    @workouts = current_user.trainer.workouts.order(:name).collect{|w| w.name}.uniq if current_user.is_trainer?
    @workouts = current_user.client.workouts.order(:name).collect{|w| w.name}.uniq if current_user.is_client?
    unless params[:client].blank?
      @workout_session.client_id = params[:client]
    end
  end

  def create
    @workout_session = WorkoutSession.new(params[:workout_session])
    if current_user.is_trainer?
      @workout_session.workout = Workout.find_or_create_by_name(:name => params[:workout_session][:workout_name], :trainer_id => current_user.trainer.id)
    elsif current_user.is_client?
      @workout_session.workout = Workout.find_or_create_by_name(:name => params[:workout_session][:workout_name], :client_id => current_user.client.id)
    end
    if @workout_session.save
      redirect_to @workout_session, :notice => "Successfully created workout session."
    else
      render :action => 'new'
    end
  end

  def edit
    @workout_session = WorkoutSession.find(params[:id])
  end

  def update
    @workout_session = WorkoutSession.find(params[:id])
    if current_user.is_trainer?
      @workout_session.workout = Workout.find_or_create_by_name(:name => params[:workout_session][:workout_name], :trainer_id => current_user.trainer.id)
    elsif current_user.is_client?
      @workout_session.workout = Workout.find_or_create_by_name(:name => params[:workout_session][:workout_name], :client_id => current_user.client.id)
    end
    if @workout_session.update_attributes(params[:workout_session])
      redirect_to @workout_session, :notice  => "Successfully updated workout session."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @workout_session = WorkoutSession.find(params[:id])
    @workout_session.destroy
    redirect_to workout_sessions_url, :notice => "Successfully destroyed workout session."
  end
end
