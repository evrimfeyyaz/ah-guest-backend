require 'rails_helper'

feature 'Room service order management' do
  context 'when signed in' do
    let!(:admin) { create(:admin) }
    let!(:order1) {
      order = create(:room_service_order)
      item = create(:room_service_item_with_mandatory_choice)
      order.cart_items.first.item = item
      order.cart_items.first.selected_options << item.choices.first.options.first
      order.save
      order
    }
    let!(:order2) { create(:room_service_order) }

    before(:each) do
      sign_in admin
    end

    scenario 'admin views a list of orders', skip: true do
      visit '/admin/room_service/orders'

      expect(page).to have_text('Open')
      expect(page).to have_text(order1.created_at.to_s(:long_ordinal))
      expect(page).to have_text(order1.cart_items.first.item.title)
      expect(page).to have_text(order1.reservation.confirmation_code)
      expect(page).to have_link('Details')
      expect(page).to have_link('Mark as Complete')

      expect(page).to have_text(order2.created_at.to_s(:long_ordinal))
      expect(page).to have_text(order2.cart_items.first.item.title)
      expect(page).to have_text(order2.reservation.confirmation_code)
    end

    scenario 'admin views the details of an order', skip: true do
      visit '/admin/room_service/orders'

      within("tr[data-room-service-order-id='#{order1.id}']") do
        click_link 'Details'
      end

      expect(page).to have_text(order1.id)
      expect(page).to have_text('Open')
      expect(page).to have_text(order1.created_at.to_s(:long_ordinal))
      expect(page).to have_text(order1.reservation.confirmation_code)
      price_in_three_digit_precision = sprintf('%0.03f', order1.total)
      expect(page).to have_text("BHD#{price_in_three_digit_precision}")

      cart_item = order1.cart_items.first
      expect(page).to have_text(cart_item.item.title)
      expect(page).to have_text(cart_item.quantity)
      expect(page).to have_text(cart_item.item.choices.first.title)
      expect(page).to have_text(cart_item.selected_options.first.title)
      expect(page).not_to have_text(cart_item.item.choices.first.options.last.title)
    end

    scenario 'admin marks an order that has an associated room number as complete', js: true, skip: true do
      order1.reservation.room_number = 123
      order1.save

      visit '/admin/room_service/orders'

      within("tr[data-room-service-order-id='#{order1.id}']") do
        page.accept_confirm do
          click_link 'Mark as Complete'
        end
      end

      within("tr[data-room-service-order-id='#{order1.id}']") do
        expect(page).to have_text('Completed')
        expect(page).not_to have_button('Mark as Complete')
      end

      expect(page).to have_current_path(admin_room_service_orders_path)
    end

    scenario 'admin marks an order that does not have an associated room number as complete', skip: true do
      visit '/admin/room_service/orders'

      within("tr[data-room-service-order-id='#{order1.id}']") do
        click_link 'Mark as Complete'
      end

      room_number = '123'
      fill_in('Room Number', with: room_number)
      click_button 'Save Room Number'

      expect(page).to have_current_path(admin_room_service_orders_path)

      within("tr[data-room-service-order-id='#{order1.id}']") do
        expect(page).to have_text('Complete')
        expect(page).not_to have_text('Open')
        expect(page).to have_text(room_number)
      end
    end
  end
end