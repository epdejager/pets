class DogsOwner < ActiveRecord::Base
  attr_accessible :compatibility

  belongs_to :dog
  belongs_to :owner
end