class AddDescToCats < ActiveRecord::Migration
  def change
    add_column :cats, :desc, :string
  end
end
