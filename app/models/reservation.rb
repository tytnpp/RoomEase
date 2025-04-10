class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time, :no_time_overlap
  validate :start_time_cannot_be_in_the_past

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

  def start_time_cannot_be_in_the_past
    if start_time.present? && start_time < Time.zone.now
      errors.add(:start_time, "cannot be in the past")
    end
  end
end
