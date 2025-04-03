class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :capacity
      t.integer :status

      t.timestamps
    end
  end
end
