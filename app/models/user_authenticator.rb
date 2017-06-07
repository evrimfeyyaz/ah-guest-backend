class UserAuthenticator
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  def initialize(user_id, auth_token)
    @errors = ActiveModel::Errors.new(self)

    @user_id = user_id
    @auth_token = auth_token
  end

  attr_accessor :auth_token
  attr_accessor :user_id
  attr_reader   :errors

  def authenticate
    errors.add(:auth_token, :blank, message: 'must exist') if auth_token.nil?
    errors.add(:user_id, :blank, message: 'must exist') if user_id.nil?

    user = User.find_by(id: user_id)
    unless user && auth_token && ActiveSupport::SecurityUtils.secure_compare(user.auth_token, auth_token)
      errors.add(:auth_token, :invalid, message: 'is invalid')
    end

    errors.empty?
  end

  # The following methods are needed to be minimally implemented

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, options = {})
    if attr == :user_id
      return 'User ID'
    end

    super
  end

  def self.lookup_ancestors
    [self]
  end
end