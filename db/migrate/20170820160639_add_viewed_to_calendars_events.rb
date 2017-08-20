class AddViewedToCalendarsEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars_events, :viewed, :boolean
  end
end
