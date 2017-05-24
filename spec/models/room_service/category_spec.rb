require 'rails_helper'

describe RoomService::Category do
  it { should have_many(:sections).
    dependent(:destroy).
    inverse_of(:category).
    with_foreign_key('room_service_category_id') }

  it { should validate_presence_of :title }
  it { should validate_attachment_content_type(:image).allowing('image/png', 'image/jpeg') }
  it { should validate_attachment_size(:image).less_than(2.megabytes) }

  context 'when created' do
    it 'creates a default section' do
      category = create(:room_service_category)

      expect(category.default_section).not_to be_nil
    end
  end
end