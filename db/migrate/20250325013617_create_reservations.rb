class CreateReservations < ActiveRecord::Migration[]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.timestamptz :start_time
      t.timestamptz :end_time

      t.timestamps
    end
  end
end
