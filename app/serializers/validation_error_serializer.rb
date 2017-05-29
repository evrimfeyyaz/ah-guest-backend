class ValidationErrorSerializer < ActiveModel::Serializer
  attributes :errors

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
