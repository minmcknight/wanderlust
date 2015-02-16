class AddFieldsToTrailUsers < ActiveRecord::Migration
  def change
    add_column :trail_users, :comment, :string
    add_column :trail_users, :rating, :integer
  end
end
