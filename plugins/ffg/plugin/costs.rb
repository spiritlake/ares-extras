module AresMUSH
  module Ffg
    def self.characteristic_xp_cost(char, old_rating, new_rating)
      cost = 0
      rating = old_rating
      while rating < new_rating
        rating = rating + 1
        cost = cost + (rating * 10)
      end
      cost
    end
    
    def self.skill_xp_cost(char, skill_name, old_rating, new_rating)
      is_career = Ffg.is_career_skill?(char, skill_name)
      cost = 0
      rating = old_rating
      while rating < new_rating
        rating = rating + 1
        cost = cost + (rating * 5) + (is_career ? 0 : 5)
      end
      cost
    end
    
    def self.specialization_xp_cost(char, spec, num_current_specs)
      is_career = Ffg.is_career_specialization?(char, spec)
      ((num_current_specs + 1) * 10) + (is_career ? 0 : 10)
    end
    
    def self.talent_xp_cost(talent, current_rating, new_rating)
      config = Ffg.find_talent_config(talent)
      tier = config['tier'] || 1
      cost = 0
      rating = current_rating
      while rating < new_rating
        cost = cost + (rating + tier) * 5
        rating = rating + 1
      end
      cost
    end
  end
end