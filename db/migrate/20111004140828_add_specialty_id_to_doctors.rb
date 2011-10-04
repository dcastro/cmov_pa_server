class AddSpecialtyIdToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :specialty_id, :integer
  end
end
