require 'rspec/expectations'

RSpec::Matchers.define :have_validation_error do |error_symbol|
  match do |record|
    (record.errors.details[attribute].map { |error_hash| error_hash[:error] }.include?(error_symbol)) &&
      (error_message.nil? || record.errors.messages[attribute].include?(error_message))
  end

  chain :on, :attribute
  chain :with_message, :error_message
end