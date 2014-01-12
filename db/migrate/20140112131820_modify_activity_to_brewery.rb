class ModifyActivityToBrewery < ActiveRecord::Migration
  def change
		remove_column :breweries, :activity, :boolean
		add_column :breweries, :active, :boolean
  end
end
