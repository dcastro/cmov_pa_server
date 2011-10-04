class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.date :birthdate
      t.string :sex
      t.string :photo
      t.string :username
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
  end
end
