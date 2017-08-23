require 'csv'


CSV.foreach('./db/pokemon.csv') { |row|
  if row[0] != 'id' && row[0].to_i <= 9
    Pokemon.find_or_create_by(name: row[1])
  end
}

Move.create(name: "Attack", damage: 17, heal: 0, dodge_chance: 0, category: "a")
Move.create(name: "Heal", damage: 0, heal: 10, dodge_chance: 0, category: "h")
Move.create(name: "Dodge", damage: 0, heal: 0, dodge_chance: 60, category: "d")
Move.create(name: "Taunt", damage: 0, heal: 0, dodge_chance: 0, category: "t")
