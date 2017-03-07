class EditGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :word, :string, :default => "BINGO"
    add_column :games, :range, :integer, :default => 15
  end
end
