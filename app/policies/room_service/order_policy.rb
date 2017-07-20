class RoomService::OrderPolicy < ApplicationPolicy
  def index?
    record.user == user
  end

  def create?
    record.reservation.user == user
  end
end