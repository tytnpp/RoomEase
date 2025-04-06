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
  { name: 'Room Territory 1', capacity: 10, status: 0, features: { tv: true, ac: true, wifi: false }},
  { name: 'Room Territory 2', capacity: 10, status: 0, features: { tv: false, ac: true, wifi: true }},
  { name: 'Meeting Room 1', capacity: 5, status: 0, features: { tv: true, ac: true, wifi: true }},
  { name: 'Meeting Room 2', capacity: 5, status: 0, features: { tv: false, ac: false, wifi: true }},
  { name: 'All Nighter', capacity: 15, status: 0, features: { tv: true, ac: true, wifi: true }},
  { name: 'Global', capacity: 20, status: 0, features: { tv: true, ac: true, wifi: true }},
]

rooms.each do |room_data|
  Room.create!(room_data)
end

puts "Created #{Room.count} rooms."