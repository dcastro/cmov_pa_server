class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :address
      t.string :sex

      t.timestamps
    end
  end
end
