require 'rails_helper'

RSpec.describe "Reservations Pages", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:room) { create(:room, name: "Meeting Room 101", capacity: 10) }

  describe "GET /activity (reservation index)" do
    context "with upcoming and past reservations" do
      it "displays both current and past reservations" do
        time = Time.zone.local(2025, 4, 10, 9, 0, 0)

        visit_as_user_at(time) do
          create_reservation(start_time: time + 1.hour, end_time: time + 2.hours)

          get activity_path

          expect(response).to have_http_status(:ok)
          expect_to_see(response.body, "Current & Upcoming Reservations")
          expect_to_see(response.body, "Reservation History")
          expect_to_see(response.body, room.name)
        end
      end
    end

    context "with no reservations" do
      it "shows empty messages" do
        visit_as_user_at(Time.zone.local(2025, 4, 10, 12, 0, 0)) do
          get activity_path
          expect_to_see(response.body, "No upcoming reservations")
          expect_to_see(response.body, "No reservation history")
        end
      end
    end
  end

  describe "GET /rooms/:room_id/reservations/new" do
    it "renders form with available time slots" do
      visit_as_user_at(Time.zone.local(2025, 4, 10, 10, 0, 0)) do
        get new_room_reservation_path(room)
        expect(response).to have_http_status(:ok)
        expect_to_see(response.body, "Reserve #{room.name}")
        expect_to_see(response.body, "Start Time")
        expect_to_see(response.body, "End Time")
      end
    end
  end

  describe "GET /rooms/:room_id/reservations/:id/edit" do
    it "renders the edit form with correct room info" do
      reservation = create(:reservation, user: user, room: room,
                                         start_time: 2.hours.from_now,
                                         end_time: 3.hours.from_now)

      sign_in user
      get edit_room_reservation_path(room, reservation)

      expect(response).to have_http_status(:ok)
      expect_to_see(response.body, "Edit Reservation")
      expect_to_see(response.body, room.name)
    end
  end

  # ---------- 🛠️ Helper Functions ----------
  def visit_as_user_at(time, &block)
    travel_to time do
      sign_in user
      yield
    end
  end

  def create_reservation(start_time:, end_time:)
    create(:reservation, user: user, room: room, start_time: start_time, end_time: end_time)
  end

  def expect_to_see(body, content)
    expect(body).to include(content)
  end
end
