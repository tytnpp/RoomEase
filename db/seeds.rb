# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data (optional, for a clean slate)
Room.destroy_all

# Create mock room data
rooms = [
  { name: 'Conference Room A', capacity: 10, status: 0 },
  { name: 'Conference Room B', capacity: 20, status: 1 },
  { name: 'Meeting Room 1', capacity: 5, status: 0 },
  { name: 'Meeting Room 2', capacity: 8, status: 2 },
  { name: 'Event Hall', capacity: 50, status: 0 }
]

rooms.each do |room_data|
  Room.create!(room_data)
end

puts "Created #{Room.count} rooms."