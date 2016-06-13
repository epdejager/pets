class CreateBirds < ActiveRecord::Migration
  def up
    create_table :birds do |t|
      t.string :name

      t.timestamps
    end
  end
end
