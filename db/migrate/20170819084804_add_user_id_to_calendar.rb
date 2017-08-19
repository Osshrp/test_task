class AddUserIdToCalendar < ActiveRecord::Migration[5.1]
  def change
    def change
      add_belongs_to :calendars, :user
    end
  end
end
