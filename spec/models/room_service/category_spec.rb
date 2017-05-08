require 'rails_helper'

describe RoomService::Category, 'Validations' do
  it { should validate_presence_of :title }
  it { should have_many :sections }
end

describe RoomService::Category, 'Sections' do
  let!(:category) { create(:room_service_category) }

  it 'creates a default section upon creation' do
    expect(category.sections.count).to eq(1)
    expect(category.sections.first.default?).to be(true)
  end

  it 'destroys dependent sections upon destroy' do
    category.sections.create(attributes_for(:room_service_section))

    expect {
      category.destroy
    }.to change(RoomService::Section, :count).by(-2)
  end

  it 'returns the default section' do
    category.sections.create(attributes_for(:room_service_section))
    default_section = category.sections.where(default: true).first

    expect(category.default_section).to eq(default_section)
  end
end