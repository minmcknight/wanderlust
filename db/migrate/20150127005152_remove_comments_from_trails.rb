class RemoveCommentsFromTrails < ActiveRecord::Migration
  def change
    remove_column :trails, :comments
  end
end
