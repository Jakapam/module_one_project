class Roster < ActiveRecord::Base
  belongs_to :pokemon
  belongs_to :trainer
  has_many :moves

  def self.default_attributes
    {:current_hp => 60,
    :move_1_id => 1,
    :move_2_id => 2,
    :move_3_id => 3,
    :move_4_id => 4}
  end

end
