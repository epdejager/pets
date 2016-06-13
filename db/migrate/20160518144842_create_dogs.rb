class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.boolean :is_boring, :default => true

      t.timestamps
    end

    #create_join_table :dogs, :owners do |t|
    create_table :dogs_owners do |t|
      t.references :dog
      t.references :owner
      t.integer :compatibility
    end
  end
end
