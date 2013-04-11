class CalendarsController < ApplicationController
  def index
    unless current_user.username == 'jeremysenn'
      @bodycomps = current_user.trainer.bodycomps
      @bodycomps_by_date = @bodycomps.group_by(&:date)
    else
      @bodycomps = Bodycomp.all
      @bodycomps_by_date = @bodycomps.group_by(&:date)
    end
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
