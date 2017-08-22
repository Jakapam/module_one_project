class CreatePokemon < ActiveRecord::Migration[5.1]
  def change
    t.string :name
  end
end
