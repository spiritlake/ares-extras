module AresMUSH    
  module Cortex
    class AttributeSetCmd
      include CommandHandler
      
      attr_accessor :target_name, :ability_name, :die_step
      
      def parse_args
        # Admin version
        if (cmd.args =~ /\//)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
          self.target_name = titlecase_arg(args.arg1)
          self.ability_name = titlecase_arg(args.arg2)
          self.die_step = downcase_arg(args.arg3)
        else
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          self.target_name = enactor_name
          self.ability_name = titlecase_arg(args.arg1)
          self.die_step = downcase_arg(args.arg2)
        end
        self.die_step = Cortex.format_die_step(self.die_step)
      end
      
      def required_args
        [self.target_name, self.ability_name, self.die_step]
      end
      
      def check_valid_die_step
        return nil if self.die_step == '0'
        return t('cortex.invalid_die_step') if !Cortex.is_valid_die_step?(self.die_step)
        return nil
      end
      
      def check_valid_ability
        return t('cortex.invalid_ability_name') if !Cortex.is_valid_attribute_name?(self.ability_name)
        return nil
      end
      
      def check_can_set
        return nil if enactor_name == self.target_name
        return nil if Cortex.can_manage_abilities?(enactor)
        return t('dispatcher.not_allowed')
      end     
      
      def check_chargen_locked
        return nil if Cortex.can_manage_abilities?(enactor)
        Chargen.check_chargen_locked(enactor)
      end
      
      def check_rating
        return nil if Cortex.can_manage_abilities?(enactor)
        Cortex.check_max_starting_rating(self.die_step, 'max_attribute_step')
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          attr = Cortex.find_attribute(model, self.ability_name)
          
          if (attr && self.die_step == '0')
            attr.delete
            client.emit_success t('cortex.ability_removed')
            return
          end
          
          if (attr)
            attr.update(die_step: self.die_step)
          else
            CortexAttribute.create(name: self.ability_name, die_step: self.die_step, character: model)
          end
         
          client.emit_success t('cortex.ability_set')
        end
      end
    end
  end
end