class Api::V0::ErrorSerializer < ActiveModel::Serializer
  attributes :error_type, :errors

  def error_type
    :unknown
  end

  def errors
    details = object.errors.details
    full_messages = object.errors.messages.each { |key, messages_array|
      messages_array.map! { |element|
        { full_message: object.errors.full_message(key, element) }
      }
    }

    details.merge(full_messages) { |key, detail_array, message_array|
      detail_array.map!.with_index { |element, index|
        element.merge(message_array[index])
      }
    }
  end
end