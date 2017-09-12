require 'rspec/expectations'

RSpec::Matchers.define :have_validation_error do |error_symbol|
  match do |record|
    (record.errors.details[attribute].include?(error: error_symbol)) &&
      (error_message.nil? || record.errors.messages[attribute].include?(error_message))
  end

  chain :on, :attribute
  chain :with_message, :error_message
end