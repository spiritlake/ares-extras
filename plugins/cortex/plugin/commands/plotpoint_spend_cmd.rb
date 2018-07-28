module AresMUSH    
  module Cortex
    class PlotPointSpendCmd
      include CommandHandler
      
      attr_accessor :points, :reason
      
      def parse_args
        args = cmd.parse_args(ArgParser.arg1_equals_arg2)
        self.points = integer_arg(args.arg1)
        self.reason = args.arg2
      end
      
      def required_args
        [self.reason, self.points]
      end      
      
      def check_has_points
        return nil if enactor.cortex_plot_points >= self.points
        return t('cortex.not_enough_points')
      end
      
      def handle
        enactor.update(cortex_plot_points: enactor.cortex_plot_points - self.points)
        Global.logger.info "#{enactor_name} spends #{self.points} plot points on #{self.reason}."
        Rooms.emit_ooc_to_room enactor_room, t('cortex.plot_point_spent', :name => enactor_name, :reason => self.reason, :points => self.points)
      end
    end
  end
end