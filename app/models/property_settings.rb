class PropertySettings
  attr_reader :name
  attr_reader :email
  attr_reader :time_zone
  attr_reader :currency

  def initialize(name:, email:, time_zone:, currency:)
    @name = name
    @email = email
    @time_zone = time_zone
    @currency = currency
  end
end