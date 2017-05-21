class Api::V0::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :auth_token
  # TODO: Consider using a slug for id as not to give away number of users.
end