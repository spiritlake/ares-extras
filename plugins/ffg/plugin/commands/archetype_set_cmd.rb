module AresMUSH    
  module Ffg
    class ArchetypeSetCmd
      include CommandHandler
      
      attr_accessor :type
      
      def parse_args
        self.type = titlecase_arg cmd.args
      end
      
      def required_args
        [self.type]
      end
      
      def check_valid_career
        return t('ffg.invalid_archetype') if !Ffg.is_valid_archetype?(self.type)
        return nil
      end
      
      def check_chargen_locked
        return nil if Ffg.can_manage_abilities?(enactor)
        Chargen.check_chargen_locked(enactor)
      end
      
      def handle
        enactor.update(ffg_archetype: self.type)
        
        config = Ffg.find_archetype_config(self.type)
        (config['characteristics'] || {}).each do |name, rating|
          Ffg.set_characteristic(enactor, name, rating)
        end
        (config['skills'] || []).each do |name|
          Ffg.set_skill(enactor, name, 1)
        end
        (config['talents'] || []).each do |name|
          talent = Ffg.find_talent(enactor, name)
          if (!talent)
            talent_config = Ffg.find_talent_config(name)
            FfgTalent.create(name: name, character: enactor, rating: talent_config['ranked'] ? 1 : 0)
          end
        end
        
        Ffg.set_archetype_bonuses(enactor, self.type)
        Ffg.update_thresholds(enactor)
        
        client.emit_success t('ffg.archetype_set')
      end
    end
  end
end