class RemoveAttrsFromDoctors < ActiveRecord::Migration
  def up
    remove_column :doctors, :name, :birthdate, :username, :hashed_password, :salt
  end

  def down
  end
end
