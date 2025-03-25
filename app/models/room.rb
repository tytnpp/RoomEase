class Room < ApplicationRecord
    enum status: { available: 0, occupied: 1, maintenance: 2 }
  
    has_many :reservations, dependent: :destroy
    validates :name, presence: true
    validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  end
  