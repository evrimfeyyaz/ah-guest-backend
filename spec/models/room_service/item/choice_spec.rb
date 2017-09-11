require 'rails_helper'

describe RoomService::Item::Choice do
  it { should have_many(:options).dependent(:destroy).inverse_of(:choice) }
  it { should belong_to(:default_option) }
  it { should have_many(:item_choice_associations).inverse_of(:choice) }
  it { should have_many(:items).through(:item_choice_associations) }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(50) }

  describe '#options' do
    it 'is not valid when there are less than two options' do
      subject.options = []

      subject.validate

      expect(subject.errors.details[:options]).to include({ error: :too_short, count: 2 })
    end

    it 'is valid when there is at least two options' do
      subject.options = build_list(:room_service_item_choice_option, 2)

      subject.validate

      expect(subject.errors.details[:options]).not_to include({ error: :too_short, count: 2 })
    end
  end
end