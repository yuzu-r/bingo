class CreateGame < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name, :limit => 50
      t.string :status, :default => "pending"
      t.timestamps null: false
    end
  end
end
