class AddIsReadToCalendarsEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars_events, :is_read, :boolean, default: false
  end
end
