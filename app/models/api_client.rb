class ApiClient < ApplicationRecord
  belongs_to :property, inverse_of: :api_clients
end
