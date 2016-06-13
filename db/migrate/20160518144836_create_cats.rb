class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.integer :breed
      t.string :color
      t.boolean :agro

      t.timestamps
    end

    # create_join_table :cats, :owners
    create_table :cats_owners do |t|
    	t.integer :cat_id, :null => false
    	t.integer :owner_id, :null => false
    end
  end
end
