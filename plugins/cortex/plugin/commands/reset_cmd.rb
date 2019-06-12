module AresMUSH    
  module Cortex
    class ResetCmd
      include CommandHandler  
      
      def check_chargen_locked
        return nil if Cortex.can_manage_abilities?(enactor)
        Chargen.check_chargen_locked(enactor)
      end
      
      def handle
        enactor.delete_cortex_abilities
        client.emit_success t('cortex.reset_abilities')
      end
    end
  end
end