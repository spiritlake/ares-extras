module AresMUSH
  module Cortex

    def self.difficulties
      [ 'Easy', 'Average', 'Hard', 'Formidable', 'Heroic', 'Incredible', 'Ridiculous', 'Impossible' ]
    end
    
    # Returns a CortexRollResults object
    def self.roll_ability(char, roll_str)
      step = Cortex.format_die_step(roll_str)
      
      if (Cortex.is_valid_die_step?(step))
        dice = Cortex.roll_die_step(step)
      
      elsif (roll_str =~ /\+/)
        abilities = roll_str.split("+")
        dice = []
        
        abilities.each do |a|
          result = Cortex.roll_ability(char, a)
          return nil if !result
          dice = dice.concat result.roll
        end
      else
        die_step = Cortex.find_ability_step(char, roll_str)
        if (!die_step)
          return nil
        end
        dice = Cortex.roll_die_step(die_step)
        Global.logger.debug "CORTEX: Rolling #{roll_str} (#{die_step}) for #{char.name}: #{dice}."
      end
      CortexRollResults.new(roll_str, dice)
    end
    
    # Returns an array of individual die rolls.
    def self.roll_die_step(step)
      return nil if !step
      step = Cortex.format_die_step(step)
      
      case step
      when 'd2'
        return [rand(2) + 1]
      when 'd4'
        return [rand(4) + 1]
      when 'd6'
        return [rand(6) + 1]
      when 'd8'
        return [rand(8) + 1]
      when 'd10'
        return [rand(10) + 1]
      when 'd12'
        return [rand(12) + 1]
      else
        if (step =~ /\+/)
          die1 = step.before("+")
          die2 = step.after("+")
          return Cortex.roll_die_step(die1).concat(Cortex.roll_die_step(die2))
        else
          return [0]
        end
      end
    end
          
    def self.get_difficulty_target(difficulty)
      case difficulty
      when "Easy"
        return 3
      when "Average"
        return 7
      when "Hard"
        return 11
      when "Formidable"
        return 15
      when "Heroic"
        return 19
      when "Incredible"
        return 23
      when "Ridiculous"
        return 27
      when "Impossible"
        return 31
      else
        raise "Invalid difficulty specified: #{difficulty}."
      end
    end
    
    def self.get_success_message(enactor_name, results, difficulty)
      if (difficulty.blank?)
        return t('cortex.roll_open', :name => enactor_name, :roll_str => results.pretty_input, :total => results.total, :dice => results.print_dice)
      end
      
      difficulty_target = Cortex.get_difficulty_target(difficulty)
      if (results.total < difficulty_target)
        return t('cortex.roll_vs_difficulty_fail', :name => enactor_name, :roll_str => results.pretty_input,
        :difficulty => difficulty, :dice => results.print_dice)
      elsif (results.total < difficulty_target + 7)
        return t('cortex.roll_vs_difficulty_success', :name => enactor_name, 
        :roll_str => results.pretty_input, :difficulty => difficulty, :dice => results.print_dice)
      else
        return t('cortex.roll_vs_difficulty_extra_success', :name => enactor_name, 
        :roll_str => results.pretty_input, :difficulty => difficulty, :dice => results.print_dice)
      end
    end
  end
end