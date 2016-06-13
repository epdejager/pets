class DoStuff < ActiveRecord::Migration
  def up
  	Cat.all.each { |c| c.update_attributes(:name => "whiskas") }
  end

  def down
  end
end
