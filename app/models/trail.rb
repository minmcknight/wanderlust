class Trail < ActiveRecord::Base
  has_many :trail_users, dependent: :destroy
  has_many :users, :through => :trail_users
validates_uniqueness_of :url
end
