class Room < ApplicationRecord
    enum status: { available: 0, occupied: 1 }
  
    has_many :reservations, dependent: :destroy
    validates :name, presence: true
    validates :capacity, numericality: { only_integer: true, greater_than: 0 }

    # Default features
  def features
    self[:features] || {}
  end

  # Add a feature
  def add_feature(feature, value = true)
    self.features[feature] = value
    save
  end

  # Remove a feature
  def remove_feature(feature)
    self.features.delete(feature)
    save
  end
end
  