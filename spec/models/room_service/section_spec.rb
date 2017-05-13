require 'rails_helper'

describe RoomService::Section, 'Validations' do
  it { should validate_presence_of :title }
  it { should belong_to :category }
  it { should have_many :items }
end

describe RoomService::Section do
  it 'ensures it is not deleted if it is the default section of an existing category'
end

describe RoomService::Section, 'Items' do
  it 'destroys dependent items upon destroy' do
    category = create(:room_service_category)
    section = category.sections.create(attributes_for(:room_service_section))
    section.items.create(attributes_for(:room_service_item))

    expect {
      section.destroy
    }.to change(RoomService::Item, :count).by(-1)
  end
end
