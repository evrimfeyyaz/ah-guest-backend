class RoomService::Category < ApplicationRecord
  has_attached_file :image, styles: { three_x: '1200x300',
                                      two_x: '600x150',
                                      one_x: '300x75' }

  validates :title, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def image_urls
    {
      '@3x' => image.url(:three_x),
      '@2x' => image.url(:two_x),
      '@1x' => image.url(:one_x)
    }
  end
end
