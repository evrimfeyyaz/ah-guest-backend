class RoomService::Tag < ApplicationRecord
  has_many :item_tag_associations, class_name: 'RoomService::Item::TagAssociation', inverse_of: :tag
  has_many :items, through: :item_tag_associations

  validates_presence_of :title
  validates_length_of :title, maximum: 30
end
