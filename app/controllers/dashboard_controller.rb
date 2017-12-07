class DashboardController < ApplicationController
  before_action :authorize

  def landing
    redirect_to recibos_path unless current_user.isAdmin
  end
end
