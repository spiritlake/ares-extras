module AresMUSH
  module Cortex  
    
    def self.app_review(char)
      text = Cortex.attribute_point_review(char)
      text << "%r"
      text << Cortex.skill_point_review(char)
      text << "%r"
      text << Cortex.traits_point_review(char)
      text << "%r"
      text
    end
      
    def self.attribute_point_review(char)
       total = 0
       char.cortex_attributes.each do |a|
          total += Cortex.points_for_step(a.die_step)
       end
       max = Global.read_config("cortex", "starting_attribute_points")
       message = t('cortex.total_attribute_points_check', :total => total, :max => max)
       status = total <= max ? t('chargen.ok') : t('chargen.too_many')
       Chargen.format_review_status message, status
    end
    
    def self.skill_point_review(char)
      total = 0
      char.cortex_skills.each do |skill|
         total += Cortex.points_for_step(skill.die_step)
         skill.specialties.each do |spec, spec_rating|
           total += (Cortex.points_for_step(spec_rating) - 6)
         end
      end
      
      max = Global.read_config("cortex", "starting_skill_points")
      message = t('cortex.total_skill_points_check', :total => total, :max => max)
      status = total <= max ? t('chargen.ok') : t('chargen.too_many')
      Chargen.format_review_status message, status
    end
    
    def self.traits_point_review(char)
      total = 0
      char.cortex_assets.each do |t|
         total += Cortex.points_for_step(t.die_step)
      end
      char.cortex_complications.each do |t|
         total -= Cortex.points_for_step(t.die_step)
      end
      max = Global.read_config("cortex", "starting_trait_points")
      message = t('cortex.total_trait_points_check', :total => total, :max => max)
      status = total <= max ? t('chargen.ok') : t('chargen.too_many')
      Chargen.format_review_status message, status
    end
  end
end