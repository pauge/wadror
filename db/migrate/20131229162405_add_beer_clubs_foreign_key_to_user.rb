class AddBeerClubsForeignKeyToUser < ActiveRecord::Migration
  def change
		add_column :beer_clubs, :user_id, :integer
  end
end
