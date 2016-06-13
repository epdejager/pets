class CreateBonesInYards < ActiveRecord::Migration
  def change
    create_table :bones_in_yards do |t|
      t.string :animal_type
      t.references :dog, :index => true

      t.timestamps
    end
  end
end
