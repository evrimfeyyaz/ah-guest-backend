class RoomService::CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_urls

  def image_urls
    {
      '@3x' => object.image.url(:three_x).empty? ? nil : object.image.url(:three_x),
      '@2x' => object.image.url(:two_x).empty? ? nil : object.image.url(:two_x),
      '@1x' => object.image.url(:one_x).empty? ? nil : object.image.url(:one_x)
    }
  end
end
