class CreateRoster < ActiveRecord::Migration[5.1]
  def change
    create_table(:rosters) do |t|
      t.integer :trainer_id
      t.integer :pokemon_id
      t.integer :current_hp
      t.integer :move_1_id
      t.integer :move_2_id
      t.integer :move_3_id
      t.integer :move_4_id
    end
  end
end
