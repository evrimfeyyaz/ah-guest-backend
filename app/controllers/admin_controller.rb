class AdminController < ApplicationController
  before_action :authenticate_admin!
  around_action :set_time_zone

  private

  def current_property
    @current_property ||= Property.find_by(subdomain: request.subdomains.first)
  end

  def set_time_zone(&block)
    Time.use_zone(current_property.time_zone, &block)
  end

  def pundit_user
    current_admin
  end
end