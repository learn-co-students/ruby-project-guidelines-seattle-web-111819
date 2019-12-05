class Member < ActiveRecord::Base
  has_many :plants
  has_many :gardens, through: :plants
end
