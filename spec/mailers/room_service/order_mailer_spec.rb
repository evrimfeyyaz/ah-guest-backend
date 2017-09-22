require 'rails_helper'

describe RoomService::OrderMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  let(:order) { create(:room_service_order) }

  describe '#admin_notification' do
    subject(:email) { RoomService::OrderMailer.admin_notification(property: @property, order: order) }

    it 'delivers to the admin email' do
      expect(email).to be_delivered_to(@property.email)
    end

    it 'contains the order ID' do
      expect(email).to have_subject(/#{order.id}/)
    end

    it 'contains when the order was created' do
      expect(email).to have_body_text(order.created_at.to_s(:short))
    end
  end
end