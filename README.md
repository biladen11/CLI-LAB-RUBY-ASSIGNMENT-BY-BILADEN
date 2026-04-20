# CLI Lab Booking System (Ruby)

## Overview

This is a small command-line lab booking system written in plain Ruby (no Rails).  
It models users, resources, and bookings, and enforces basic booking rules.

**Main goal: practice backend thinking with Ruby objects and simple business rules.**

## Features

- Users can book resources (e.g., microscopes, projectors).
- A resource can have at most one active booking.
- Bookings have statuses: `active` or `cancelled`.
- Cancelling a booking makes the resource available again.
- Invalid actions raise clear errors.
- Basic authorization: only users with role `student` or `assistant` can create bookings.
- `BookingManager` keeps a list of bookings and can:
  - list active bookings,
  - list available resources.

## File Structure

```text
RUBY ASSIGNMENT BY BILADEN/
  app.rb
  user.rb
  resource.rb
  booking.rb
  booking_manager.rb
  roles_and_statuses.rb
  errors.rb
  test/
    test_booking.rb
  README.md
  