class AddImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :images, :binary
  end
end
