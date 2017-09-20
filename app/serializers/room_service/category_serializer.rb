class RoomService::CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_urls, :available_from, :available_until

  def image_urls
    {
      '@3x' => object.image.url(:three_x).empty? ? nil : object.image.url(:three_x),
      '@2x' => object.image.url(:two_x).empty? ? nil : object.image.url(:two_x),
      '@1x' => object.image.url(:one_x).empty? ? nil : object.image.url(:one_x)
    }
  end

  def available_from
    object.available_from.strftime('%H:%M') if object.available_from
  end

  def available_until
    object.available_until.strftime('%H:%M') if object.available_until
  end
end
