module AresMUSH
  module Traits
    class TraitsTemplate < ErbTemplateRenderer
      
      attr_accessor :char, :traits
      
      def initialize(char, traits)
        @char = char
        @traits = traits
        super File.dirname(__FILE__) + "/traits.erb"
      end
    end
  end
end