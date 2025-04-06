class AddFeaturesToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :features, :json
  end
end
