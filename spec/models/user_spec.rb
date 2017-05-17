require 'rails_helper'

describe User, 'Validations' do
  it { should validate_presence_of :email }
  it { should have_secure_password }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
end
