class RoomService::CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_urls, :available_from_utc, :available_until_utc

  def image_urls
    {
      '@3x' => object.image.url(:three_x).empty? ? nil : object.image.url(:three_x),
      '@2x' => object.image.url(:two_x).empty? ? nil : object.image.url(:two_x),
      '@1x' => object.image.url(:one_x).empty? ? nil : object.image.url(:one_x)
    }
  end

  def available_from_utc
    object.available_from.utc_from_zone(instance_options[:property_time_zone]).strftime('%H:%M') if object.available_from
  end

  def available_until_utc
    object.available_until.utc_from_zone(instance_options[:property_time_zone]).strftime('%H:%M') if object.available_until
  end
end
