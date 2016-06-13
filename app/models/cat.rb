class Cat < ActiveRecord::Base
  attr_accessible :name, :desc

  has_and_belongs_to_many :owners

  validates_presence_of :desc
end
