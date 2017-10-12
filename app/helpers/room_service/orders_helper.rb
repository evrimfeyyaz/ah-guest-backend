module RoomService::OrdersHelper
  def order_summary(order)
    titles_of_cart_items = order.cart_items.map { |cart_item| cart_item.item.title }.join(', ')

    truncate(titles_of_cart_items, length: 30, omission: '...')
  end

  def order_status_label(order)
    if order.open?
      content_tag(:span, 'Open', class: 'label label-danger')
    else
      content_tag(:span, 'Complete', class: 'label label-success')
    end
  end
end