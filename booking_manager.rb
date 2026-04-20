class BookingManager
  attr_reader :bookings

  def initialize
    @bookings = []
  end

  def add_booking(booking)
    @bookings << booking
  end

  def active_bookings
    @bookings.select(&:active?)
  end

  def available_resources(resources)
    resources.select(&:available?)
  end
end