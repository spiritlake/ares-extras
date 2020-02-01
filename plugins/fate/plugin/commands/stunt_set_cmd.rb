module AresMUSH    
  module Fate
    class StuntSetCmd
      include CommandHandler
      
      attr_accessor :target_name, :stunt_name, :stunt_description
      
      def parse_args
        # Admin version
        if (cmd.args =~ /\//)
          self.target_name = titlecase_arg(cmd.args.before("/"))
          self.stunt_name = titlecase_arg(cmd.args.after("/").before("="))
          self.stunt_description = trim_arg(cmd.args.after("/").after("="))
        else
          args = cmd.parse_args(ArgParser.arg1_equals_optional_arg2)
          self.target_name = enactor_name
          self.stunt_name = titlecase_arg(args.arg1)
          self.stunt_description = trim_arg(args.arg2)
        end
      end
      
      def required_args
        [self.target_name, self.stunt_name]
      end
      
      def check_can_set
        return nil if enactor_name == self.target_name
        return nil if Fate.can_manage_abilities?(enactor)
        return t('dispatcher.not_allowed')
      end     
      
      def check_chargen_locked
        return nil if Fate.can_manage_abilities?(enactor)
        Chargen.check_chargen_locked(enactor)
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          
          if (!self.stunt_description || self.stunt_description.blank?)
            stunts_config = Global.read_config('fate', 'stunts')
            if (stunts_config.any? { |s| s['name'].titlecase == self.stunt_name })
              self.stunt_description = t('fate.see_stunts_list')
            end
          end
          
          if (!self.stunt_description)
            client.emit_failure t('fate.stunt_description_required')
            return
          end
          
          stunts = model.fate_stunts || {}
          stunts[self.stunt_name] = self.stunt_description
          model.update(fate_stunts: stunts)
          Fate.update_refresh(model)
                    
          client.emit_success t('fate.stunt_set')
        end
      end
    end
  end
end