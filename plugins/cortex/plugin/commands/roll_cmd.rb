module AresMUSH    
  module Cortex
    class RollCmd
      include CommandHandler
      
      attr_accessor :roll_str, :difficulty
  
      def parse_args
         return if !cmd.args
         self.roll_str = trim_arg(cmd.args.before("vs"))
         self.difficulty = titlecase_arg(cmd.args.after("vs"))
      end
      
      def required_args
        [ self.roll_str ]
      end
      
      def check_difficulty
        return nil if self.difficulty.blank?
        return t('cortex.invalid_difficulty', :names => Cortex.difficulties.join(' ')) if !Cortex.difficulties.include?(self.difficulty)
        return nil
      end
      
      def handle
        results = Cortex.roll_ability(enactor, self.roll_str)
        
        if (!results)
          client.emit_failure t('cortex.invalid_ability')
          return
        end

        if (results.is_botch?)
          Rooms.emit_ooc_to_room enactor_room, t('cortex.roll_botch', :name => enactor_name, :roll_str => results.pretty_input, :dice => results.print_dice)
          return
        end
        
        message = Cortex.get_success_message(enactor_name, results, self.difficulty)
        Rooms.emit_ooc_to_room enactor_room, message               
      end
    end
  end
end