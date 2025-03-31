class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time, :no_time_overlap

  private

  def end_time_after_start_time
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def no_time_overlap
    overlapping_reservations = Reservation.where(room_id: room_id)
                                          .where.not(id: id) # Exclude the current reservation
                                          .where("start_time < ? AND end_time > ?", end_time, start_time)

    if overlapping_reservations.exists?
      errors.add(:base, "This room is already reserved for the selected time.")
    end
  end
end
