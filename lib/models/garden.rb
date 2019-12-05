class Garden < ActiveRecord::Base
  has_many :plants
  has_many :members, through: :plants
 
end
