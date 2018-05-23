module AresMUSH
  module Cortex
    def self.life_points(char)
      stats = Global.read_config("cortex", "life_points")
      life_points = 0
      stats.each do |s|
        step = Cortex.find_ability_step(char, s)
        life_points += Cortex.points_for_step(step)
      end
      life_points
    end
    
    def self.derived_stat(char, config_setting)
      stats = Global.read_config("cortex", config_setting)
      dice = []
      stats.each do |s|
        step = Cortex.find_ability_step(char, s)
        if (step)
          dice << step
        end
      end
      dice.join("+")
    end
    
    def self.initiative(char)
      Cortex.derived_stat(char, "initiative")
    end
    
    def self.endurance(char)
      Cortex.derived_stat(char, "endurance")
    end
    
    def self.resistance(char)
      Cortex.derived_stat(char, "resistance")
    end
  end
end