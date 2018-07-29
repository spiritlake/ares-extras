module AresMUSH
  module Ffg  
    
    def self.app_review(char)
      if (!char.ffg_archetype || !char.ffg_career)
        return Chargen.format_review_status t('ffg.must_set_archetype'), t('chargen.not_set')
      end
      
      text = Ffg.xp_review(char)
      text << "%r"
      text << Ffg.talent_review(char)
      text << "%r"
      text
    end
      
    def self.xp_review(char)
       config = Ffg.find_archetype_config(char.ffg_archetype)
       max = config['xp'] || 0
       total = Ffg.points_on_characteristics(char)
       total = total + Ffg.points_on_skills(char)
       total = total + Ffg.points_on_talents(char)
       
       # TODO - points on talents
       # TODO - points on specs
       
       # TODO - talent review:  force talents, prereqs, talent tree balance

       message = t('ffg.xp_spent_check', :total => total, :max => max)
       status = total <= max ? t('chargen.ok') : t('chargen.too_many')
       Chargen.format_review_status message, status
    end
    
    def self.points_on_characteristics(char)
      total = 0
      char.ffg_characteristics.each do |c|
        config = Ffg.find_archetype_config(char.ffg_archetype)
        starting_rating = (config['characteristics'] || {})[c.name] || 0
        xp_cost = Ffg.characteristic_xp_cost(char, starting_rating, c.rating)
        total = total + xp_cost
      end
      total
    end
    
    def self.points_on_skills(char)
      total = 0
      char.ffg_skills.each do |s|
        config = Ffg.find_archetype_config(char.ffg_archetype)
        starting_rating = (config['skills'] || []).include?(s.name) ? 1 : 0
        xp_cost = Ffg.characteristic_xp_cost(char, starting_rating, s.rating)
        total = total + xp_cost
      end
      total
    end
    
    def self.points_on_talents(char)
      total = 0
      char.ffg_talents.each do |t|
        config = Ffg.find_archetype_config(char.ffg_archetype)
        starting_rating = (config['talents'] || []).include?(t.name) ? 1 : 0
        xp_cost = Ffg.characteristic_xp_cost(char, starting_rating, c.rating)
        total = total + xp_cost
      end
      total
    end
  end
end