class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
end
