class CreateWorkdays < ActiveRecord::Migration
  def change
    create_table :workdays do |t|
      t.integer :weekday
      t.integer :start
      t.integer :end
      t.integer :schedule_plan_id

      t.timestamps
    end
  end
end
