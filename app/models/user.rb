class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token

  validates_presence_of :first_name
  validates_length_of   :first_name, maximum: 60

  validates_presence_of :last_name
  validates_length_of   :last_name, maximum: 60

  validates_presence_of   :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of     :email, with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/i # Email validation regex from: http://www.regular-expressions.info/email.html

  validates_length_of :password, minimum: 8, maximum: 128, on: :create
end