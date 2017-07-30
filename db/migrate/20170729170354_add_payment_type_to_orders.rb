class AddPaymentTypeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :room_service_orders, :payment_type, :integer, limit: 1, default: 0, null: false
  end
end
