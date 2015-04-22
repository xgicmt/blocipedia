class AddLastModifiedToWikis < ActiveRecord::Migration
  def change
  	    add_column :wikis, :modified_by, :integer
  end
end
