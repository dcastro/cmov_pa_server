class ChangePhotoDefault < ActiveRecord::Migration
  def up
    change_column :doctors, :photo, :string, :default => 'http://t1.stooorage.com/thumbs/1073/4386724_new_user.jpg'
  end

  def down
  end
end
