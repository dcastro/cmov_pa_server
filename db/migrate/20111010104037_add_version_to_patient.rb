class AddVersionToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :version, :integer, :default => 1
  end
end
