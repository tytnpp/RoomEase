require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    sign_in @user

    @room = rooms(:room_territory_1)
  end

  test "should get show with time slots" do
    travel_to Time.zone.local(2025, 4, 10, 10, 0, 0) do
      get room_url(@room)

      assert_response :success

      time_slots = assigns(:time_slots)
      assert_not_nil time_slots

      assert_equal 9, time_slots.first[:start_time].hour
      assert_equal 18, time_slots.last[:end_time].hour

      time_slots.each do |slot|
        assert slot.key?(:available), "Slot missing :available"
        assert slot.key?(:in_progress), "Slot missing :in_progress"
        assert slot.key?(:closed), "Slot missing :closed"
      end
    end
  end
end
