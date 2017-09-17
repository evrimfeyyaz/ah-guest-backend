class RoomService::Category < ApplicationRecord
  DEFAULT_SECTION_TITLE = '__default'

  serialize :available_from, Tod::TimeOfDay
  serialize :available_until, Tod::TimeOfDay

  has_many :sections, foreign_key: 'room_service_category_id',
           dependent: :destroy, inverse_of: :category
  has_attached_file :image, styles: { three_x: '1200x300', two_x: '600x150', one_x: '300x75' }

  validates_presence_of :title
  validates_length_of :title, maximum: 50
  validates_attachment :image, content_type: { content_type: %w(image/jpeg image/png) },
                       size: { in: 0..2.megabytes }

  after_create :create_default_section

  def default_section
    sections.where(title: DEFAULT_SECTION_TITLE).take
  end

  def available_at?(time)
    if available_from.nil? || available_until.nil?
      return true
    end

    available_range = Tod::Shift.new(available_from, available_until)
    available_range.include?(Tod::TimeOfDay(time))
  end

  private

  def create_default_section
    sections.create(title: DEFAULT_SECTION_TITLE)
  end
end