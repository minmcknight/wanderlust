class CreateTrailUsers < ActiveRecord::Migration
  def change
    create_table :trail_users do |t|
      t.integer :user_id
      t.integer :trail_id

      t.timestamps null: false
    end
  end
end
