class WorkoutSessionsController < ApplicationController
  def index
    @workout_sessions = WorkoutSession.all
  end

  def show
    @workout_session = WorkoutSession.find(params[:id])
  end

  def new
    @workout_session = WorkoutSession.new
  end

  def create
    @workout_session = WorkoutSession.new(params[:workout_session])
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
