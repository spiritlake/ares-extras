module AresMUSH
  module Traits
    class TraitsCmd
      include CommandHandler
                
      attr_accessor :name
            
      def parse_args
        self.name = cmd.args || enactor_name
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          template = TraitsTemplate.new(model, model.traits || {})
          client.emit template.render     
        end
      end
    end
  end
end
