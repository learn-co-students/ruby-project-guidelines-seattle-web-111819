class Plant < ActiveRecord::Base
  belongs_to :member
  belongs_to :garden

  
end
