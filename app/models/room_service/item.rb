class RoomService::Item < ApplicationRecord
  belongs_to :sub_category, foreign_key: 'room_service_sub_category_id', counter_cache: 'room_service_items_count', inverse_of: :items
  has_and_belongs_to_many :tags, inverse_of: :items, foreign_key: 'room_service_item_id',
                          association_foreign_key: 'room_service_tag_id'
  has_and_belongs_to_many :choices, inverse_of: :items, class_name: 'RoomService::ItemChoice',
                          foreign_key: 'room_service_item_id',
                          association_foreign_key: 'room_service_item_choice_id'

  validates_presence_of :title
  validates_numericality_of :price, greater_than_or_equal_to: 0

  delegate :available?, to: 'sub_category', allow_nil: true
  delegate :available_from, to: 'sub_category', allow_nil: true
  delegate :available_until, to: 'sub_category', allow_nil: true
end