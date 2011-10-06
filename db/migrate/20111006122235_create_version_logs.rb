class CreateVersionLogs < ActiveRecord::Migration
  def change
    create_table :version_logs do |t|
      t.string :table
      t.integer :version

      t.timestamps
    end
  end
end
