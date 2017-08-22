class CreateMove < ActiveRecord::Migration[5.1]
  def change
    create_table(:moves) do |t|
      t.string :name
      t.integer :damage
      t.integer :heal
      t.integer :dodge_chance
    end
  end
end
