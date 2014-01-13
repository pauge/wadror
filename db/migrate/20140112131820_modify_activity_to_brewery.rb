class ModifyActivityToBrewery < ActiveRecord::Migration
  def change
		add_column :breweries, :activity, :boolean
  end
end
