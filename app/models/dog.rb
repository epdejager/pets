class Dog < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :owners
  has_many :bones_in_yards

end
