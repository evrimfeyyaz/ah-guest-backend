class RoomService::OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end
  
  def index?
    record.user == user
  end

  def create?
    record.reservation.user == user
  end
end