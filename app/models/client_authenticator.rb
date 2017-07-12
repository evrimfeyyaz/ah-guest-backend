class ClientAuthenticator
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def initialize(client_secret)
    @errors = ActiveModel::Errors.new(self)

    @client_secret = client_secret
  end

  attr_accessor :client_secret
  attr_reader   :errors

  def authenticate
    errors.add(:client_secret, :blank, message: 'must exist') if client_secret.nil?
    errors.add(:client_secret, :invalid, message: 'is invalid') unless client_secret == Rails.application.secrets.client_secret

    errors.empty?
  end

  # The following methods are needed to be minimally implemented

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.lookup_ancestors
    [self]
  end
end