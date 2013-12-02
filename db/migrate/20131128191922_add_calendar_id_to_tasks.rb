class AddCalendarIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :google_event_id, :string
  end
end
