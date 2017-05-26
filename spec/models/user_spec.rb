require 'rails_helper'

describe User do
  it { should have_secure_password }
  it { should have_db_column(:auth_token) }
  it { should have_many(:room_service_orders).dependent(:destroy).inverse_of(:user).class_name('RoomService::Order') }
  it { should have_many(:stays).dependent(:destroy).inverse_of(:user) }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_values('john@example.com',
                           'john.doe@example.com',
                           'j@example.com',
                           'john@example.verylongtld').for(:email) }
  it { should_not allow_values('',
                               '@',
                               '@.',
                               '@example.com',
                               'www.example.com',
                               '.',
                               '.com',
                               'john doe@example.com',
                               'john@example',
                               'john@example.',
                               'john@example.a').for(:email) }

  it { should validate_length_of(:password).is_at_least(8).is_at_most(128).on(:create) }

  it { should validate_presence_of :first_name }
  it { should validate_length_of(:first_name).is_at_most(60) }

  it { should validate_presence_of :last_name }
  it { should validate_length_of(:last_name).is_at_most(60) }
end
