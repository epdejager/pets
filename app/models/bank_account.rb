class BankAccount < ActiveRecord::Base
  attr_accessible :name, :value, :owner

  has_one :owner
end
