class RoomService::CartItem < ApplicationRecord
  belongs_to :order, inverse_of: :cart_items, foreign_key: 'room_service_order_id'
  belongs_to :item, foreign_key: 'room_service_item_id'
  has_and_belongs_to_many :selected_options, class_name: 'RoomService::ItemChoiceOption',
                          foreign_key: 'room_service_cart_item_id',
                          association_foreign_key: 'room_service_item_choice_option_id'

  validates_numericality_of :quantity, greater_than: 0
  validate :availability_at_the_moment
  validate :existence_of_selection_for_non_optional_choices
  validate :single_selection_for_single_option_choices

  private

  def has_selected_option_for_choice(choice)
    (choice.option_ids & selected_option_ids).any?
  end

  def has_single_or_no_selected_option_for_choice(choice)
    (choice.option_ids & selected_option_ids).length <= 1
  end

  def availability_at_the_moment
    errors.add(:base, :not_available_at_the_moment,
               message: '"%{item_title}" is not available at the moment (only available from %{item_available_from} to %{item_available_until})',
               item_title: item.title,
               item_available_from: item.available_from.strftime('%H:%M'),
               item_available_until: item.available_until.strftime('%H:%M'),
               item_id: item.id) unless item.nil? || item.available?(DateTime.current)
  end

  def existence_of_selection_for_non_optional_choices
    item&.choices&.each do |choice|
      errors.add(:base, :selection_required_for_non_optional_choice,
                 message: '"%{choice_title}" requires at least one selection',
                 choice_title: choice.title,
                 choice_id: choice.id) unless choice.optional || has_selected_option_for_choice(choice)
    end
  end

  def single_selection_for_single_option_choices
    item&.choices&.each do |choice|
      errors.add(:base, :only_single_selection_allowed_for_choice,
                 message: 'Only a single selection allowed for "%{choice_title}"',
                 choice_title: choice.title,
                 choice_id: choice.id) unless choice.allows_multiple_options || has_single_or_no_selected_option_for_choice(choice)
    end
  end
end
