class RoomService::OrderMailerPreview < ActionMailer::Preview
  def admin_notification
    RoomService::OrderMailer.admin_notification(property: Property.first, order: RoomService::Order.first)
  end
end
