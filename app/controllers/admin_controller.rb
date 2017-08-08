class AdminController < ApplicationController
  before_action :authenticate_admin!
  around_action :set_time_zone

  def set_time_zone(&block)
    Time.use_zone('Riyadh', &block)
  end

  def pundit_user
    current_admin
  end
end