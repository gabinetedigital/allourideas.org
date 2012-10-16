class AddGabinetedigitalIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :gabinetedigital_id, :integer
  end

  def self.down
    remove_column :users, :gabinetedigital_id
  end
end
