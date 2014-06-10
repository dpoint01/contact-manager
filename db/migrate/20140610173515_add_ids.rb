class AddIds < ActiveRecord::Migration
  def change
    add_column :contacts, :id, :serial
  end
end
