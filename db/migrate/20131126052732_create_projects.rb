class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :created_by
      t.string :name
      t.binary :description
      t.integer :status

      t.timestamps
    end
  end
end
