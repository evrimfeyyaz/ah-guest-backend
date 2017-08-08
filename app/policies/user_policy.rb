class UserPolicy < ApplicationPolicy
  def show?
    user == record
  end

  def permitted_attributes
    [:first_name, :last_name, :email, :password, :password_confirmation]
  end
end