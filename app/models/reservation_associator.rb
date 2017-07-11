class ReservationAssociator
  include ActiveModel::Validations
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  validate :either_check_in_date_or_confirmation_code_must_exist
  validates_presence_of :user

  def initialize(user:, confirmation_code: nil, check_in_date: nil)
    @errors = ActiveModel::Errors.new(self)

    @user = user
    @confirmation_code = confirmation_code
    @check_in_date = check_in_date
  end

  attr_accessor :user
  attr_reader :associated_reservation
  attr_reader :check_in_date
  attr_reader :confirmation_code
  attr_reader :errors

  def associate
    errors.clear

    unless valid?
      return false
    end

    if confirmation_code != nil
      associate_by_confirmation_code
    else
      associate_by_check_in_date
    end
  end

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.lookup_ancestors
    [self]
  end

  private

  def associate_by_check_in_date
    if check_in_date.blank?
      return false
    end

    reservations_with_check_in_date = Reservation.where(check_in_date: check_in_date,
                                                        user_id: nil,
                                                        first_name: user.first_name,
                                                        last_name: user.last_name)

    reservations_count = reservations_with_check_in_date.count
    if reservations_count == 1
      reservation = reservations_with_check_in_date.take

      reservation.user = user

      if reservation.save
        @associated_reservation = reservation
      else
        errors.add(:base, :error_saving_association, message: 'There was an error saving the association')
      end
    else
      errors.add(:base, :reservation_cannot_be_associated_by_check_in_date,
                 message: "Reservation can't be associated by check-in date")
    end

    errors.empty?
  end

  def associate_by_confirmation_code
    if confirmation_code.blank?
      return false
    end

    reservation = Reservation.where(confirmation_code: confirmation_code)

    if reservation.count > 0
      reservation = reservation.take

      if reservation.user != nil
        errors.add(:base, :reservation_is_already_associated,
                   message: 'The reservation with the given confirmation code is already associated with a user')
      else
        reservation.user = user

        if reservation.save
          @associated_reservation = reservation
        else
          errors.add(:base, :error_saving_association, message: 'There was an error saving the association')
        end
      end
    else
      errors.add(:base, :reservation_cannot_be_found,
                 message: 'No reservation was found for the given confirmation code')
    end

    errors.empty?
  end

  def either_check_in_date_or_confirmation_code_must_exist
    errors.add(:base, :either_check_in_date_or_confirmation_code_must_exist,
               message: 'Either check-in date or confirmation code must exist') if confirmation_code.blank? && check_in_date.blank?
  end
end