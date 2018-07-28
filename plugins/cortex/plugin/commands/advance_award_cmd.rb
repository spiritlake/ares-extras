module AresMUSH    
  module Cortex
    class AdvancementPointAwardCmd
      include CommandHandler
      
      attr_accessor :target_name, :points
      
      def parse_args
        args = cmd.parse_args(ArgParser.arg1_equals_arg2)
        self.target_name = titlecase_arg(args.arg1)
        self.points = integer_arg(args.arg2)
      end
      
      def required_args
        [self.target_name, self.points]
      end      
      
      def check_is_allowed
        return nil if Cortex.can_manage_abilities?(enactor)
        t('dispatcher.not_allowed')
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          model.update(cortex_advance_points: model.cortex_advance_points + self.points)
          Global.logger.info "#{enactor_name} awarded #{self.points} advancement points to #{self.target_name}."
          client.emit_success t('cortex.advance_point_award', :name => self.target_name)
        end
      end
    end
  end
end