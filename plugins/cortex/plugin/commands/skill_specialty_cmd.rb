module AresMUSH    
  module Cortex
    class SkillSpecialtyCmd
      include CommandHandler
      
      attr_accessor :target_name, :ability_name, :die_step, :specialty_name
      
      def parse_args
        # Admin version
        if (cmd.args =~ /\=/)
          args = cmd.parse_args(/(?<arg1>[^\=]+)\=(?<arg2>[^\/]+)\/(?<arg3>.+)\/(?<arg4>.+)/)
          self.target_name = titlecase_arg(args.arg1)
          self.ability_name = titlecase_arg(args.arg2)
          self.specialty_name = titlecase_arg(args.arg3)
          self.die_step = downcase_arg(args.arg4)
        else
          args = cmd.parse_args(/(?<arg1>.+)\/(?<arg2>.+)\/(?<arg3>.+)/)
          self.target_name = enactor_name
          self.ability_name = titlecase_arg(args.arg1)
          self.specialty_name = titlecase_arg(args.arg2)
          self.die_step = downcase_arg(args.arg3)
        end
        self.die_step = Cortex.format_die_step(self.die_step)
      end
      
      def required_args
        [self.target_name, self.ability_name, self.specialty_name, self.die_step]
      end
      
      def check_valid_die_step
        return nil if self.die_step == '0'
        return t('cortex.invalid_die_step') if !Cortex.is_valid_die_step?(self.die_step)
        return t('cortex.invalid_specialty_step') if [ 'd2', 'd4', 'd6' ].include?(self.die_step)
        return nil
      end
      
      def check_valid_ability
        return t('cortex.invalid_ability_name') if !Cortex.is_valid_skill_name?(self.ability_name)
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
        Cortex.check_max_starting_rating(self.die_step, 'max_specialty_skill_step')
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          skill = Cortex.find_skill(model, self.ability_name)
          
          if (!skill || skill.die_step != "d6")
            client.emit_failure t('cortex.specialty_skill_limit')
            return
          end

          specs = skill.specialties
          if (self.die_step == '0')
            specs.delete self.specialty_name
          else
            specs[self.specialty_name] = self.die_step
          end
          
          skill.update(specialties: specs)
          
          client.emit_success t('cortex.specialty_set')
        end
      end
    end
  end
end