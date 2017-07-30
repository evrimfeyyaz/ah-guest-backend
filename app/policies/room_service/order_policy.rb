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
    record.reservation.users.include?(user)
  end

  def permitted_attributes
    [:reservation_id, :payment_type,
     cart_items_attributes: [:quantity,
                             :special_request,
                             :room_service_item_id,
                             selected_option_ids: []]]
  end
end