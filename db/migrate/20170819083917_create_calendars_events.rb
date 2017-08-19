class CreateCalendarsEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :calendars_events do |t|
      t.integer :calendar_id
      t.integer :event_id

      t.timestamps
    end
  end
end
