require 'rails_helper'

describe RoomService::CartItem do
  it { should belong_to(:order).inverse_of(:cart_items) }
  it { should belong_to(:item) }
  it { should have_many(:selected_option_associations).inverse_of(:cart_item) }
  it { should have_many(:selected_options).through(:selected_option_associations) }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  describe 'validates availability of the item' do
    context 'when item is available' do
      it 'does not have a validation error' do
        subject.item = build(:available_room_service_item)

        subject.validate

        expect(subject.errors[:item]).not_to include("\"#{subject.item.title}\" is not available at the moment (only available from #{subject.item.available_from.in_time_zone('Riyadh').strftime('%H:%M')} to #{subject.item.available_until.in_time_zone('Riyadh').strftime('%H:%M')} in local time)")
      end
    end

    context 'when item is not available' do
      it 'has a validation error' do
        subject.item = build(:unavailable_room_service_item)

        subject.validate

        expect(subject.errors[:item]).to include("\"#{subject.item.title}\" is not available at the moment (only available from #{subject.item.available_from.in_time_zone('Riyadh').strftime('%H:%M')} to #{subject.item.available_until.in_time_zone('Riyadh').strftime('%H:%M')} in local time)")
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

          expect(subject.errors[:selected_options]).to include("should include a selection for \"#{choice.title}\"")
        end
      end

      context 'and a selected option' do
        it 'does not have a validation error' do
          subject.item = create(:room_service_item_with_non_optional_choice)
          choice = subject.item.choices.first
          subject.selected_options << choice.options.first

          subject.validate

          expect(subject.errors[:selected_options]).not_to include("should include a selection for \"#{choice.title}\"")
        end
      end
    end

    context 'when there is an optional choice and no selected choice' do
      it 'does not have a validation error' do
        subject.item = create(:room_service_item_with_optional_choice)
        choice = subject.item.choices.first

        subject.validate

        expect(subject.errors[:selected_options]).not_to include("should include a selection for \"#{choice.title}\"")
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

          expect(subject.errors[:selected_options]).to include("can only include one selection for \"#{choice.title}\"")
        end
      end

      context 'and one selected option' do
        it 'does not have a validation error' do
          subject.item = create(:room_service_item_with_single_option_choice)
          choice = subject.item.choices.first
          subject.selected_options << choice.options.first

          subject.validate

          expect(subject.errors[:selected_options]).not_to include("can only include one selection for \"#{choice.title}\"")
        end
      end
    end

    context 'when there is a multiple-option choice and multiple selections' do
      it 'does not have a validation error' do
        subject.item = create(:room_service_item_with_multiple_option_choice)
        choice = subject.item.choices.first
        subject.selected_option_ids = choice.option_ids

        subject.validate

        expect(subject.errors[:selected_options]).not_to include("can only include one selection for \"#{choice.title}\"")
      end
    end
  end

  describe '#unit_price' do
    it 'returns the unit price of the item with selected options' do
      choice = create(:room_service_item_choice_with_options)
      selected_option = choice.options.first
      selected_option.price = 0.500
      item = create(:room_service_item, choices: [choice], price: 1.000)

      subject.selected_options << selected_option
      subject.item = item

      expect(subject.unit_price).to eq(1.500)
    end
  end

  describe '#total' do
    it 'returns the total price of the cart item taking quantity into account' do
      choice = create(:room_service_item_choice_with_options)
      selected_option = choice.options.first
      selected_option.price = 0.500
      item = create(:room_service_item, choices: [choice], price: 1.000)

      subject.selected_options << selected_option
      subject.item = item
      subject.quantity = 2

      expect(subject.total).to eq(3.000)
    end
  end
end