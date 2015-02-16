class TrailUser < ActiveRecord::Base
  belongs_to :User
  belongs_to :Trail

end
