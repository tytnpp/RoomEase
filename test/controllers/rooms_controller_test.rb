require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    sign_in @user

    @room = rooms(:room_territory_1)
  end

  test "should get show with time slots" do
    @reservation = reservations(:reservation_one)

    get room_url(@room)

    assert_response :success

    assert_not_nil assigns(:time_slots)

    assert_equal 9, assigns(:time_slots).first[:start_time].hour
    assert_equal 18, assigns(:time_slots).last[:end_time].hour

    assert_includes assigns(:time_slots).first, :available
  end
end
