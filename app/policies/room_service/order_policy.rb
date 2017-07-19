class RoomService::OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user)
    end
  end

  def index?
    user == record unless record == nil
  end

  def create?
    record.reservation.user == user
  end
end