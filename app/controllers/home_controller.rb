class HomeController < ApplicationController
  
#  before_filter :login_required, :except => []

  def index
    if current_user.blank?
      redirect_to login_path
    end
  end

end
