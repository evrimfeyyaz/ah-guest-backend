class RoomService::Item < ApplicationRecord
  belongs_to :category_section, foreign_key: 'room_service_category_section_id',
             counter_cache: 'room_service_items_count', inverse_of: :items, class_name: 'RoomService::Category::Section'
  has_many :tag_associations, inverse_of: :item, class_name: 'RoomService::Item::TagAssociation',
           foreign_key: 'room_service_item_id', dependent: :destroy
  has_many :tags, through: :tag_associations
  has_many :item_choice_associations, inverse_of: :item, class_name: 'RoomService::Item::ChoiceAssociation',
           foreign_key: 'room_service_item_id', dependent: :destroy
  has_many :choices, through: :item_choice_associations
  has_many :cart_items, inverse_of: :item, class_name: 'RoomService::CartItem',
           foreign_key: 'room_service_item_id', dependent: :destroy

  validates_presence_of :title
  validates_length_of :title, maximum: 50
  validates_length_of :short_description, maximum: 100
  validates_numericality_of :price, greater_than_or_equal_to: 0

  delegate :available_at?, to: :category_section, allow_nil: true
  delegate :available_from, to: :category_section, allow_nil: true
  delegate :available_until, to: :category_section, allow_nil: true
  delegate :available_from_local, to: :category_section, allow_nil: true
  delegate :available_until_local, to: :category_section, allow_nil: true
end