class RoomService::OrderPolicy < ApplicationPolicy
  def index?
    record.user == user
  end

  def create?
    record.reservation.users.include?(user)
  end

  def permitted_attributes
    if admin?
      [:reservation_id, { reservation_attributes: [:room_number] },
      :payment_type, cart_items_attributes: [:quantity,
                               :special_request,
                               :room_service_item_id,
                               selected_option_ids: []]]
    else
      [:reservation_id, :payment_type,
       cart_items_attributes: [:quantity,
                               :special_request,
                               :room_service_item_id,
                               selected_option_ids: []]]
    end
  end
end