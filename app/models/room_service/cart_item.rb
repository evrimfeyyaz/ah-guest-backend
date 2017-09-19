class RoomService::CartItem < ApplicationRecord
  belongs_to :order, inverse_of: :cart_items, foreign_key: 'room_service_order_id'
  belongs_to :item, foreign_key: 'room_service_item_id'
  has_many :selected_option_associations,
           inverse_of: :cart_item, foreign_key: 'room_service_cart_item_id'
  has_many :selected_options, through: :selected_option_associations

  validates_numericality_of :quantity, greater_than: 0
  validate :item_available
  validate :mandatory_choices_have_selected_options
  validate :single_option_choices_have_single_selection

  def unit_price
    item.price + selected_options.reduce(0) { |sum, option| sum + option.price }
  end

  def total
    unit_price * quantity
  end

  private

  def has_selected_option_for_choice?(choice)
    (choice.option_ids & selected_option_ids).any?
  end

  def has_single_or_no_selected_option_for_choice?(choice)
    (choice.option_ids & selected_option_ids).length <= 1
  end

  def item_available
    errors.add(:item, :not_available_at_the_moment,
               message: '"%{title}" is not available at the moment (only available from %{available_from_local} to %{available_until_local})',
               title: item.title,
               available_from_local: item.available_from.strftime('%H:%M'),
               available_until_local: item.available_until.strftime('%H:%M'),
               id: item.id) unless item.nil? || item.available_at?(Time.current)
  end

  def mandatory_choices_have_selected_options
    item&.choices&.each do |choice|
      errors.add(:selected_options, :does_not_include_selection_for_mandatory_choice,
                 message: 'should include a selection for "%{choice_title}"',
                 choice_title: choice.title,
                 choice_id: choice.id) unless choice.optional || has_selected_option_for_choice?(choice)
    end
  end

  def single_option_choices_have_single_selection
    item&.choices&.each do |choice|
      errors.add(:selected_options, :includes_multiple_selections_for_single_option_choice,
                 message: 'can only include one selection for "%{choice_title}"',
                 choice_title: choice.title,
                 choice_id: choice.id) unless choice.allows_multiple_options || has_single_or_no_selected_option_for_choice?(choice)
    end
  end
end
