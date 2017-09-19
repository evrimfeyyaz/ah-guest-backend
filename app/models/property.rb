class Property < ApplicationRecord
  has_many :api_clients, inverse_of: :property, dependent: :destroy
end
