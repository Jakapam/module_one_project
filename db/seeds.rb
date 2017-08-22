require 'csv'


CSV.foreach('./db/pokemon.csv') { |row|
  if row[0] != 'id' && row[0].to_i <= 151
    Pokemon.find_or_create_by(name: row[1])
  end
}

Move.create(name: "Attack", damage: 6, heal: 0, dodge_chance: 0, type: "a")
Move.create(name: "Heal", damage: 0, heal: 4, dodge_chance: 0, type: "h")
Move.create(name: "Dodge", damage: 0, heal: 0, dodge_chance: 50, type: "d")
Move.create(name: "Taunt", damage: 0, heal: 0, dodge_chance: 0, type: "t")
