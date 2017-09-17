require 'rails_helper'

describe RoomService::CartItem do
  it { should belong_to(:order).inverse_of(:cart_items) }
  it { should belong_to(:item) }
  it { should have_many(:selected_option_associations).inverse_of(:cart_item) }
  it { should have_many(:selected_options).through(:selected_option_associations) }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  describe 'item available validation' do
    context 'when item is available' do
      it 'does not have a validation error' do
        subject.item = build(:available_room_service_item)

        subject.validate

        expect(subject).not_to have_validation_error(:not_available_at_the_moment).on(:item)
      end
    end

    context 'when item is not available' do
      it 'has a validation error' do
        subject.item = build(:unavailable_room_service_item)

        subject.validate

        expect(subject).to have_validation_error(:not_available_at_the_moment).on(:item)
      end
    end
  end

  describe 'mandatory choices have selected options validation' do
    context 'when there is a mandatory choice' do
      context 'and no selected option' do
        it 'does have a validation error' do
          subject.item = build(:room_service_item_with_mandatory_choice)

          subject.validate

          expect(subject).to have_validation_error(:does_not_include_selection_for_mandatory_choice).on(:selected_options)
        end
      end

      context 'and a selected option' do
        it 'does not have a validation error' do
          subject.item = build(:room_service_item_with_mandatory_choice)
          choice = subject.item.choices.first
          subject.selected_options << choice.options.first

          subject.validate

          expect(subject).not_to have_validation_error(:does_not_include_selection_for_mandatory_choice).on(:selected_options)
        end
      end
    end

    context 'when there is an optional choice and no selected choice' do
      it 'does not have a validation error' do
        subject.item = build(:room_service_item_with_optional_choice)

        subject.validate

        expect(subject).not_to have_validation_error(:does_not_include_selection_for_mandatory_choice).on(:selected_options)
      end
    end
  end

  describe 'single option choices have only single selection validation' do
    context 'when there is a single-option choice' do
      context 'and more than one selected option' do
        it 'does have a validation error' do
          subject.item = build(:room_service_item_with_single_option_choice)
          choice = subject.item.choices.first
          subject.selected_option_ids = choice.option_ids

          subject.validate

          expect(subject).to have_validation_error(:includes_multiple_selections_for_single_option_choice).on(:selected_options)
        end
      end

      context 'and one selected option' do
        it 'does not have a validation error' do
          subject.item = build(:room_service_item_with_single_option_choice)
          choice = subject.item.choices.first
          subject.selected_options << choice.options.first

          subject.validate

          expect(subject).not_to have_validation_error(:includes_multiple_selections_for_single_option_choice).on(:selected_options)
        end
      end
    end

    context 'when there is a multiple-option choice and multiple selections' do
      it 'does not have a validation error' do
        subject.item = build(:room_service_item_with_multiple_option_choice)
        choice = subject.item.choices.first
        subject.selected_option_ids = choice.option_ids

        subject.validate

        expect(subject).not_to have_validation_error(:includes_multiple_selections_for_single_option_choice).on(:selected_options)
      end
    end
  end

  describe '#unit_price' do
    it 'returns the unit price of the item with selected options' do
      choice = build(:room_service_item_choice)
      selected_option = choice.options.first
      selected_option.price = 0.500
      item = build(:room_service_item, choices: [choice], price: 1.000)

      subject.selected_options << selected_option
      subject.item = item

      expect(subject.unit_price).to eq(1.500)
    end
  end

  describe '#total' do
    it 'returns the total price of the cart item taking quantity into account' do
      choice = build(:room_service_item_choice)
      selected_option = choice.options.first
      selected_option.price = 0.500
      item = build(:room_service_item, choices: [choice], price: 1.000)

      subject.selected_options << selected_option
      subject.item = item
      subject.quantity = 2

      expect(subject.total).to eq(3.000)
    end
  end
end