class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :name
      t.string :url
      t.string :geocode
      t.string :comments

      t.timestamps null: false
    end
  end
end
