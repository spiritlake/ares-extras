module AresMUSH    
  module Ffg
    class CharacteristicSetCmd
      include CommandHandler
      
      attr_accessor :target_name, :ability_name, :rating
      
      def parse_args
        # Admin version
        if (cmd.args =~ /\//)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
          self.target_name = titlecase_arg(args.arg1)
          self.ability_name = titlecase_arg(args.arg2)
          self.rating = integer_arg(args.arg3)
        else
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          self.target_name = enactor_name
          self.ability_name = titlecase_arg(args.arg1)
          self.rating = integer_arg(args.arg2)
        end
      end
      
      def required_args
        [self.target_name, self.ability_name, self.rating]
      end
      
      def check_valid_rating
        return nil if !self.rating
        return t('ffg.invalid_characteristic_rating') if self.rating > 5 || self.rating < 1
        return nil
      end
      
      def check_valid_ability
        return t('ffg.invalid_ability_name') if !Ffg.is_valid_characteristic_name?(self.ability_name)
        return nil
      end
      
      def check_can_set
        return nil if enactor_name == self.target_name
        return nil if Ffg.can_manage_abilities?(enactor)
        return t('dispatcher.not_allowed')
      end     
      
      def check_chargen_locked
        return nil if Ffg.can_manage_abilities?(enactor)
        Chargen.check_chargen_locked(enactor)
      end
      
      def check_rating
        return nil if Ffg.can_manage_abilities?(enactor)
        if (!enactor.is_approved?)
          return Ffg.check_max_starting_rating(self.rating, 'max_cg_characteristic_rating')
        end
        return nil
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          Ffg.set_characteristic(model, self.ability_name, self.rating)
          client.emit_success t('ffg.ability_set')
        end
      end
    end
  end
end