class RoomService::Category < ApplicationRecord
  DEFAULT_SECTION_TITLE = '__default'

  has_attached_file :image, styles: { three_x: '1200x300',
                                      two_x: '600x150',
                                      one_x: '300x75' }
  has_many :sections, foreign_key: :room_service_category_id, dependent: :destroy

  after_create :add_default_section

  validates :title, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def image_urls
    {
      '@3x' => image.url(:three_x).empty? ? nil : image.url(:three_x),
      '@2x' => image.url(:two_x).empty? ? nil : image.url(:two_x),
      '@1x' => image.url(:one_x).empty? ? nil : image.url(:one_x)
    }
  end

  def default_section
    sections.where(default: true).first
  end

  private

    def add_default_section
      sections.create(title: DEFAULT_SECTION_TITLE, default: true)
    end
end
