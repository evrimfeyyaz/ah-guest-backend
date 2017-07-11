class Admin::OrderNotifierMailer < ApplicationMailer
  default from: 'no-reply@automatedhotel.com'

  def new_order_email(order)
    @order = order

    mail(to: ENV["ORDER_NOTIFICATION_EMAIL"], subject: "New Room Service Order \##{@order.id}")
  end
end
