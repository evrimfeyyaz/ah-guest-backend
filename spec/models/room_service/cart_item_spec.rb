require 'rails_helper'

describe RoomService::CartItem do
  it { should belong_to(:order).inverse_of(:cart_items).with_foreign_key('room_service_order_id') }
  it { should belong_to(:item).with_foreign_key('room_service_item_id') }
  it { should have_and_belong_to_many(:selected_options).class_name('RoomService::ItemChoiceOption').
    with_foreign_key('room_service_cart_item_id') }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  describe 'validates availability of the item' do
    context 'when item is available' do
      it 'does not have a validation error' do
        subject.item = build(:available_room_service_item)

        subject.validate

        expect(subject.errors[:base]).not_to include("\"#{subject.item.title}\" is not available at the moment")
      end
    end

    context 'when item is not available' do
      it 'has a validation error' do
        subject.item = build(:unavailable_room_service_item)

        subject.validate

        expect(subject.errors[:base]).to include("\"#{subject.item.title}\" is not available at the moment (only available from #{subject.item.available_from.strftime('%H:%M')} to #{subject.item.available_until.strftime('%H:%M')})")
      end
    end
  end

  describe 'validates all non-optional choices has at least one selected option' do
    context 'when there is a non-optional choice' do
      context 'and no selected option' do
        it 'does have a validation error' do
          subject.item = create(:room_service_item_with_non_optional_choice)
          choice = subject.item.choices.first

          subject.validate

          expect(subject.errors[:base]).to include("\"#{choice.title}\" requires at least one selection")
        end
      end

      context 'and a selected option' do
        it 'does not have a validation error' do
          subject.item = create(:room_service_item_with_non_optional_choice)
          choice = subject.item.choices.first
          subject.selected_options << choice.options.first

          subject.validate

          expect(subject.errors[:base]).not_to include("\"#{choice.title}\" requires at least one selection")
        end
      end
    end

    context 'when there is an optional choice and no selected choice' do
      it 'does not have a validation error' do
        subject.item = create(:room_service_item_with_optional_choice)
        choice = subject.item.choices.first

        subject.validate

        expect(subject.errors[:base]).not_to include("\"#{choice.title}\" requires at least one selection")
      end
    end
  end

  describe 'validates all single-option choices does not have more than one option selected' do
    context 'when there is a single-option choice' do
      context 'and more than one selected option' do
        it 'does have a validation error' do
          subject.item = create(:room_service_item_with_single_option_choice)
          choice = subject.item.choices.first
          subject.selected_option_ids = choice.option_ids

          subject.validate

          expect(subject.errors[:base]).to include("Only a single selection allowed for \"#{choice.title}\"")
        end
      end

      context 'and one selected option' do
        it 'does not have a validation error' do
          subject.item = create(:room_service_item_with_single_option_choice)
          choice = subject.item.choices.first
          subject.selected_options << choice.options.first

          subject.validate

          expect(subject.errors[:base]).not_to include("Only a single selection allowed for \"#{choice.title}\"")
        end
      end
    end

    context 'when there is a multiple-option choice and multiple selections' do
      it 'does not have a validation error' do
        subject.item = create(:room_service_item_with_multiple_option_choice)
        choice = subject.item.choices.first
        subject.selected_option_ids = choice.option_ids

        subject.validate

        expect(subject.errors[:base]).not_to include("Only a single selection allowed for \"#{choice.title}\"")
      end
    end
  end
end