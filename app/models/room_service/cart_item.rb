class RoomService::CartItem < ApplicationRecord
  belongs_to :order, inverse_of: :cart_items, foreign_key: 'room_service_order_id'
  belongs_to :item, foreign_key: 'room_service_item_id'
  has_and_belongs_to_many :selected_options, class_name: 'RoomService::ItemChoiceOption',
                          foreign_key: 'room_service_cart_item_id',
                          association_foreign_key: 'room_service_item_choice_option_id'

  validates_numericality_of :quantity, greater_than: 0
  validate :availability_of_item_at_the_moment
  validate :existence_of_selection_for_non_optional_choices
  validate :single_selection_for_single_option_choices

  def unit_price
    item.price + selected_options.reduce(0) { |sum, option| sum + option.price }
  end

  def total
    unit_price * quantity
  end

  private

  def has_selected_option_for_choice(choice)
    (choice.option_ids & selected_option_ids).any?
  end

  def has_single_or_no_selected_option_for_choice(choice)
    (choice.option_ids & selected_option_ids).length <= 1
  end

  def availability_of_item_at_the_moment
    errors.add(:item, :not_available_at_the_moment,
               message: '"%{title}" is not available at the moment (only available from %{available_from_utc} to %{available_until_utc})',
               title: item.title,
               available_from_utc: item.available_from.utc.strftime('%H:%M'),
               available_until_utc: item.available_until.utc.strftime('%H:%M'),
               id: item.id) unless item.nil? || item.available?(DateTime.current)
  end

  def existence_of_selection_for_non_optional_choices
    item&.choices&.each do |choice|
      errors.add(:selected_options, :does_not_include_selection_for_non_optional_choice,
                 message: 'should include a selection for "%{choice_title}"',
                 choice_title: choice.title,
                 choice_id: choice.id) unless choice.optional || has_selected_option_for_choice(choice)
    end
  end

  def single_selection_for_single_option_choices
    item&.choices&.each do |choice|
      errors.add(:selected_options, :includes_multiple_selections_for_single_option_choice,
                 message: 'can only include one selection for "%{choice_title}"',
                 choice_title: choice.title,
                 choice_id: choice.id) unless choice.allows_multiple_options || has_single_or_no_selected_option_for_choice(choice)
    end
  end
end
