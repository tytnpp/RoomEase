class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
