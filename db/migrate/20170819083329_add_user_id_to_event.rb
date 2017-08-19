class AddUserIdToEvent < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :events, :user
  end
end
