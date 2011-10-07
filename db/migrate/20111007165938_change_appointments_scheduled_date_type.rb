class ChangeAppointmentsScheduledDateType < ActiveRecord::Migration
  def up
    change_column :appointments, :scheduled_date, :datetime
  end

  def down
    change_column :appointments, :scheduled_date, :date
  end
end
