class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    current_user?
  end

  def current_user?
    user == record
  end

  def permitted_attributes
    [:first_name, :last_name, :email, :password, :password_confirmation]
  end
end