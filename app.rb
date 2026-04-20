require_relative "user"
require_relative "resource"
require_relative "booking"
require_relative "booking_manager"
require_relative "roles_and_statuses"
require_relative "errors"


Booking.reset_ids!

manager = BookingManager.new

user1 = User.new(id: 1, name: "Mahi", role: Roles::STUDENT)
user2 = User.new(id: 2, name: "Alex", role: Roles::ASSISTANT)

resource1 = Resource.new(id: 1, name: "Microscope",  category: "lab")
resource2 = Resource.new(id: 2, name: "Projector",   category: "av")

puts "Users:"
p user1
p user2
puts

puts "Resources:"
p resource1
p resource2
puts

puts "Creating first booking for resource1 by user1..."
booking1 = Booking.new(user: user1, resource: resource1)
manager.add_booking(booking1)
puts "Booking created: id=#{booking1.id}, status=#{booking1.status}"
puts "Resource1 available? #{resource1.available?}"
puts

puts "Attempting conflicting booking for same resource..."
begin
  booking2 = Booking.new(user: user2, resource: resource1)
  manager.add_booking(booking2)
rescue BookingError => e

  puts "Conflict blocked with error: #{e.message}"
end
puts "Resource1 available after conflict attempt? #{resource1.available?}"
puts

puts "Cancelling first booking..."
booking1.cancel
puts "Booking1 status after cancel: #{booking1.status}"

puts "Resource1 available after cancel? #{resource1.available?}"
puts

puts "Active bookings:"
manager.active_bookings.each do |b|
  puts "  Booking ##{b.id} for #{b.resource.name} by #{b.user.name}"
end

puts
puts "Available resources:"
manager.available_resources([resource1, resource2]).each do |r|
  puts "  #{r.name} (#{r.category})"
end