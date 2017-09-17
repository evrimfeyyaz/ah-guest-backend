require 'rails_helper'

describe RoomService::Item::Choice do
  it { should have_many(:options).inverse_of(:choice).dependent(:destroy) }
  it { should belong_to(:default_option) }
  it { should have_many(:item_choice_associations).inverse_of(:choice) }
  it { should have_many(:items).through(:item_choice_associations) }

  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(50) }

  # On why we're not using a shoulda matcher for ensuring options has at least two elements:
  # https://github.com/thoughtbot/shoulda-matchers/issues/1007
  describe 'options has a minimum of two elements validation' do
    it 'adds a validation error when there are less than two options' do
      subject.options = []

      expect(subject).to have_validation_error(:too_short).on(:options)
    end

    it 'does not add a validation error when there is at least two options' do
      subject.options = build_list(:room_service_item_choice_option, 2)

      expect(subject).not_to have_validation_error(:too_short).on(:options)
    end
  end
end