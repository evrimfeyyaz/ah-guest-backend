class RoomService::Category < ApplicationRecord
  DEFAULT_SUB_CATEGORY_TITLE = '__default'

  has_many :sub_categories, foreign_key: 'room_service_category_id', dependent: :destroy, inverse_of: :category
  has_attached_file :image, styles: { three_x: '1200x300', two_x: '600x150', one_x: '300x75' }

  validates_presence_of :title
  validates_attachment :image, content_type: { content_type: %w(image/jpeg image/png) },
                       size: { in: 0..2.megabytes }

  after_create :create_default_sub_category

  def default_sub_category
    sub_categories.where(title: DEFAULT_SUB_CATEGORY_TITLE).first
  end

  def available?(time)
    if available_from.nil? || available_until.nil?
      return true
    end

    is_time_between(time.utc.strftime('%H:%M'), available_from.utc.strftime('%H:%M'), available_until.utc.strftime('%H:%M'))
  end

  private

  def create_default_sub_category
    sub_categories.create(title: DEFAULT_SUB_CATEGORY_TITLE)
  end

  def is_time_between(time, from, til)
    if from <= til
      time >= from && time <= til
    else
      time >= from || time <= til
    end
  end
end