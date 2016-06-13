class CreateCellPhones < ActiveRecord::Migration
  def change
    create_table :cell_phones do |t|
      t.string :number
      t.belongs_to :owner
      t.timestamps
    end
  end
end
