class ValidationErrorSerializer < ActiveModel::Serializer
  attributes :error_type, :errors

  def error_type
    :validation
  end

  def errors
    details = object.errors.details
    messages = object.errors.messages.each { |key, messages_array|
      messages_array.map! { |element|
        { message: object.errors.full_message(key, element) }
      }
    }

    details.merge(messages) { |key, detail_array, message_array|
      detail_array.map!.with_index { |element, index|
        element.merge(message_array[index])
      }
    }
  end
end