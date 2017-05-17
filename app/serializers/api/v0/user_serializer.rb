class Api::V0::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :auth_token
end