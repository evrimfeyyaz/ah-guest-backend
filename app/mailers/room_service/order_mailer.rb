class RoomService::OrderMailer < ApplicationMailer
  def admin_notification(property:, order:)
    @order = order

    mail(to: property.email, subject: "New Room Service Order \##{order.id}")
  end
end
