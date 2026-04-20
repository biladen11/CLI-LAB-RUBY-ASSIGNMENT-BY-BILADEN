require "minitest/autorun"
require_relative "../user"
require_relative "../resource"
require_relative "../booking"
require_relative "../roles_and_statuses"
require_relative "../errors"

class BookingTest < Minitest::Test
  def setup
    Booking.reset_ids!
    @user     = User.new(id: 1, name: "Mahi", role: Roles::STUDENT)
    @resource = Resource.new(id: 1, name: "Microscope", category: "lab")
  end

 
  def test_booking_an_available_resource
    booking = Booking.new(user: @user, resource: @resource)

    assert_equal BookingStatus::ACTIVE, booking.status
    refute @resource.available?
    assert_equal booking, @resource.current_booking
  end


  def test_booking_an_unavailable_resource_raises_error
    first_booking = Booking.new(user: @user, resource: @resource)
    refute @resource.available?
    assert first_booking.active?

    assert_raises(BookingError) do
      Booking.new(user: @user, resource: @resource)
    end
  end

  def test_cancelling_changes_status
    booking = Booking.new(user: @user, resource: @resource)
    assert_equal BookingStatus::ACTIVE, booking.status

    booking.cancel

    assert_equal BookingStatus::CANCELLED, booking.status
    assert booking.cancelled?
    refute booking.active?
  end

  
  def test_cancelling_makes_resource_available
    booking = Booking.new(user: @user, resource: @resource)
    refute @resource.available?

    booking.cancel

    assert @resource.available?
    assert_nil @resource.current_booking
  end

  
  def test_only_student_or_assistant_can_book
    staff = User.new(id: 2, name: "Prof", role: Roles::ADMIN)

    assert_raises(AuthorizationError) do
      Booking.new(user: staff, resource: @resource)
    end
  end
end
