class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.date :birthdate
      t.string :username
      t.string :hashed_password
      t.string :salt
      t.references :utilizador, :polymorphic => true

      t.timestamps
    end
  end
end
