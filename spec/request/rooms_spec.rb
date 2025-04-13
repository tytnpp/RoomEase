# spec/requests/rooms_spec.rb
require 'rails_helper'

RSpec.describe "Rooms#index", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  context "during working hours" do
    before do
      create_room_with_status(name: "Meeting Room A", capacity: 5)
      create_room_with_status(name: "Meeting Room B", capacity: 4, reservation: true)
    end

    it "displays 'In Use' for reserved room at that time and 'Available' for others" do
      visit_rooms_at(Time.zone.local(2025, 4, 10, 10, 30, 0)) do |body|
        expect_to_see_room_status(body, "Meeting Room A", "Available")
        expect_to_see_room_status(body, "Meeting Room B", "In Use")
      end
    end
  end

  context "after working hours" do
    before do
      create_room_with_status(name: "Late Room", capacity: 6)
    end

    it "displays 'Closed' for all rooms" do
      visit_rooms_at(Time.zone.local(2025, 4, 10, 19, 0, 0)) do |body|
        expect_to_see_room_status(body, "Late Room", "Closed")
      end
    end
  end

  def create_room_with_status(name:, capacity:, reservation: false)
    room = create(:room, name: name, capacity: capacity)
    if reservation
      travel_to(Time.zone.local(2025, 4, 10, 10, 0, 0)) do
        create(:reservation, room: room,
                             start_time: Time.zone.local(2025, 4, 10, 10, 0, 0),
                             end_time: Time.zone.local(2025, 4, 10, 11, 0, 0),
                             user: user)
      end
    end
    room
  end

  def visit_rooms_at(time)
    travel_to time do
      sign_in user
      get rooms_path
      expect(response).to have_http_status(:ok)
      yield response.body if block_given?
    end
  end

  def expect_to_see_room_status(body, room_name, status_label)
    expect(body).to include(room_name)
    expect(body).to include(status_label)
  end
end
