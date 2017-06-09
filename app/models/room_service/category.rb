class RoomService::Category < ApplicationRecord
  DEFAULT_SECTION_TITLE = '__default'

  has_many :sections, foreign_key: 'room_service_category_id', dependent: :destroy, inverse_of: :category
  has_attached_file :image, styles: { three_x: '1200x300', two_x: '600x150', one_x: '300x75' }

  validates_presence_of :title
  validates_attachment :image, content_type: { content_type: %w(image/jpeg image/png) },
                       size: { in: 0..2.megabytes }

  after_create :create_default_section

  def default_section
    sections.where(title: DEFAULT_SECTION_TITLE).first
  end

  def available?(time)
    if available_from.nil? || available_until.nil?
      return true
    end

    time.strftime('%H%M') >= available_from.strftime('%H%M') &&
      time.strftime('%H%M') <= available_until.strftime('%H%M')
  end

  private

  def create_default_section
    sections.create(title: DEFAULT_SECTION_TITLE)
  end
end