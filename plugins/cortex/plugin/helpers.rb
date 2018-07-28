module AresMUSH
  module Cortex
    def self.die_steps
      [ 'd2', 'd4', 'd6', 'd8', 'd10', 'd12', 'd12+d2', 'd12+d4', 'd12+d6', 'd12+d8', 'd12+d10', 'd12+d12' ]
    end
        
    def self.is_valid_die_step?(step)
      Cortex.die_steps.include?(step)
    end
    
    def self.is_valid_attribute_name?(name)
      return false if !name
      names = Global.read_config('cortex', 'attributes').map { |a| a['name'].downcase }
      names.include?(name.downcase)
    end
    
    def self.is_valid_skill_name?(name)
      return false if !name
      names = Global.read_config('cortex', 'skills').map { |a| a['name'].downcase }
      names.include?(name.downcase)
    end
    
    def self.can_manage_abilities?(actor)
      return false if !actor
      actor.has_permission?("manage_apps")
    end
    
    def self.find_attribute(model, ability_name)
      name_downcase = ability_name.downcase
      model.cortex_attributes.select { |a| a.name.downcase == name_downcase }.first
    end
    
    def self.find_skill(model, ability_name)
      name_downcase = ability_name.downcase
      model.cortex_skills.select { |a| a.name.downcase == name_downcase }.first
    end
    
    def self.find_asset(model, ability_name)
      name_downcase = ability_name.downcase
      model.cortex_assets.select { |a| a.name.downcase == name_downcase }.first
    end
    
    def self.find_complication(model, ability_name)
      name_downcase = ability_name.downcase
      model.cortex_complications.select { |a| a.name.downcase == name_downcase }.first
    end
    
    def self.find_asset_config(ability_name)
      return nil if !ability_name
      assets = Global.read_config('cortex', 'assets')
      assets.select { |a| a['name'].downcase == ability_name.downcase }.first
    end
      
    def self.find_complication_config(ability_name)
      return nil if !ability_name
      complications = Global.read_config('cortex', 'complications')
      complications.select { |a| a['name'].downcase == ability_name.downcase }.first
    end
    
    def self.format_die_step(input)
      return "" if !input
      input.downcase.gsub(" ", "")
    end
    
    def self.find_ability_step(char, ability_name)
      return nil if !ability_name
      
      case ability_name.downcase
      when "endurance"
        return Cortex.endurance(char)
      when "resistance"
        return Cortex.resistance(char)
      when "initiative"
        return Cortex.initiative(char)
      end
      
      [ char.cortex_skills, char.cortex_attributes, char.cortex_assets, char.cortex_complications ].each do |list|
        found = list.select { |a| a.name.downcase == ability_name.downcase }.first
        return found.die_step if found
      end
      char.cortex_skills.each do |skill|
        skill.specialties.each do |k, v|
          if (k.downcase == ability_name.downcase)
            return v
          end
        end
      end
      return nil
    end
    
    def self.check_max_starting_rating(die_step, config_setting)
      max_step = Global.read_config("cortex", config_setting)
      max_index = Cortex.die_steps.index(max_step)
      index = Cortex.die_steps.index(die_step)
      
      return nil if !index
      return nil if index <= max_index
      return t('cortex.starting_rating_limit', :step => max_step)
    end
    
    def self.points_for_step(die_step)
      costs = {
        'd2' => 2,
        'd4' => 4,
        'd6' => 6,
        'd8' => 8,
        'd10' => 10,
        'd12' => 12,
        'd12+d2' => 14,
        'd12+d4' => 16,
        'd12+d6' => 18,
        'd12+d8' => 20,
        'd12+d10' => 22,
        'd12+d12' => 24
      }

      costs[die_step] || 0
    end

  end
end