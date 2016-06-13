class CellPhone < ActiveRecord::Base
  attr_accessible :number, :owner_id

  belongs_to :owner, inverse_of: :cell_phone
end
