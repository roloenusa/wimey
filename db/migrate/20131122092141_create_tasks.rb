class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :created_by
      t.integer :user_id
      t.string :title
      t.string :description
      t.timestamp :start_date
      t.timestamp :end_date
      t.integer :status

      t.timestamps
    end
  end
end
