class AddStyleForeignKeyToBeer < ActiveRecord::Migration
  def change
		remove_column :beers, :style
		add_column :beers, :style_id, :integer
  end
end
