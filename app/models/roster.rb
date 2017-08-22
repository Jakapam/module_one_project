class Roster < ActiveRecord::Base
  belongs_to :pokemon
  belongs_to :trainer
  has_many :moves
end
