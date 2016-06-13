class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.integer :age
      t.string :address

      t.timestamps
    end
  end
end
