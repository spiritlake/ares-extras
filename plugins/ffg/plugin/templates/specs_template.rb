module AresMUSH    
  module Ffg
    class SpecializationsTemplate < ErbTemplateRenderer

      attr_accessor :types
      
      def initialize(types)
        self.types = types
        super File.dirname(__FILE__) + "/specs.erb"
      end
      
      def skills(type)
        (type['skills'] || []).join(", ")
      end
    end
  end
end