class Resource
  attr_reader :id, :name, :category, :current_booking

  def initialize(id:, name:, category:)
    @id              = id
    @name            = name
    @category        = category
    @current_booking = nil
  end

  def available?
    @current_booking.nil?
  end

  def assign_booking(booking)
    @current_booking = booking
  end

  def clear_booking
    @current_booking = nil
  end
end