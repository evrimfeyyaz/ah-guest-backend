class RoomService::Tag < ApplicationRecord
  has_many :item_tag_associations, class_name: 'RoomService::Item::TagAssociation',
           inverse_of: :tag, foreign_key: 'room_service_tag_id', dependent: :destroy
  has_many :items, through: :item_tag_associations

  validates_presence_of :title
  validates_length_of :title, maximum: 30
end
