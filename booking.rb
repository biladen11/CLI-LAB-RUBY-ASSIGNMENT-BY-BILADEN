require "time"
require_relative "booking_manager"
require_relative "roles_and_statuses"
require_relative "errors"

class Booking
  attr_reader :id, :user, :resource, :status, :created_at

  @@next_id = 1

  def self.reset_ids!
    @@next_id = 1
  end

  def initialize(user:, resource:)
    @id        = @@next_id
    @@next_id += 1

    @user      = user
    @resource  = resource
    @status    = BookingStatus::ACTIVE
    @created_at = Time.now

    validate_user_can_book!
    validate_resource_available!

    # Link booking to resource
    @resource.assign_booking(self)
    # Optionally also register with a BookingManager externally
  end

  def cancel
    raise BookingError, "Booking already cancelled" if cancelled?

    @status = BookingStatus::CANCELLED
    resource.clear_booking if resource.current_booking == self
  end

  def active?
    status == BookingStatus::ACTIVE
  end

  def cancelled?
    status == BookingStatus::CANCELLED
  end

  private

  def validate_user_can_book!
    return if user.can_create_booking?

    raise AuthorizationError,
          "User with role '#{user.role}' is not allowed to create bookings"
  end

  def validate_resource_available!
    return if resource.available?

    raise BookingError, "Resource '#{resource.name}' is not available"
  end
end