require_relative "roles_and_statuses"

class User
  attr_reader :id, :name, :role

  def initialize(id:, name:, role:)
    @id   = id
    @name = name
    @role = role
  end

  def can_create_booking?
    [Roles::STUDENT, Roles::ASSISTANT].include?(role)
  end
end