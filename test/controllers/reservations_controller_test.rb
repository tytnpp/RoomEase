require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @room = rooms(:room_territory_1)
    @reservation = reservations(:reservation_one)
  end

  test "should get new" do
    get new_room_reservation_url(@room)
    assert_response :success
  end

  test "should create reservation" do
    assert_difference("Reservation.count") do
      post room_reservations_url(@room), params: {
        reservation: {
          start_time: Time.zone.now + 1.hour,
          end_time: Time.zone.now + 2.hours
        }
      }
    end

    assert_redirected_to rooms_path
  end

  test "should get edit" do
    get edit_room_reservation_url(@room, @reservation)
    assert_response :success
  end

  test "should update reservation" do
    patch room_reservation_url(@room, @reservation), params: {
      reservation: {
        start_time: Time.zone.now + 3.hours,
        end_time: Time.zone.now + 4.hours
      }
    }

    assert_redirected_to activity_path
  end

  test "should destroy reservation" do
    assert_difference("Reservation.count", -1) do
      delete room_reservation_url(@room, @reservation)
    end

    assert_redirected_to activity_path
  end

  test "should get activity" do
    get activity_url
    assert_response :success
    assert_not_nil assigns(:current_reservations)
    assert_not_nil assigns(:past_reservations)
  end
end
