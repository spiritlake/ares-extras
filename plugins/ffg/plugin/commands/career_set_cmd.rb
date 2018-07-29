module AresMUSH    
  module Ffg
    class CareerSetCmd
      include CommandHandler
      
      attr_accessor :career
      
      def parse_args
        self.career = titlecase_arg cmd.args
      end
      
      def required_args
        [self.career]
      end
      
      def check_valid_career
        return t('ffg.invalid_career') if !Ffg.is_valid_career?(self.career)
        return nil
      end
      
      def check_chargen_locked
        return nil if Ffg.can_manage_abilities?(enactor)
        Chargen.check_chargen_locked(enactor)
      end
      
      def handle
        enactor.update(ffg_career: self.career)
        Ffg.set_career_bonuses(enactor, self.career)
        client.emit_success t('ffg.career_set')
      end
    end
  end
end