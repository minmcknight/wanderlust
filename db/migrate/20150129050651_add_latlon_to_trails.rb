class AddLatlonToTrails < ActiveRecord::Migration
  def change
    add_column :trails, :lon, :decimal
    add_column :trails, :lat, :decimal
    remove_column :trails, :geocode
  end
end
