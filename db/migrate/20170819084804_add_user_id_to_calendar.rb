class AddUserIdToCalendar < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :calendars, :user
  end
end
