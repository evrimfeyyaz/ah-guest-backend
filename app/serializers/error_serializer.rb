class ErrorSerializer < ActiveModel::Serializer
  attributes :errors

  def errors
    return object.errors
  end
end
