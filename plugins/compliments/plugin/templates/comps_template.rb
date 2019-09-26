module AresMUSH
  module Compliments
    class CompsTemplate < ErbTemplateRenderer
      attr_accessor :char, :paginator

      def initialize(char, paginator)
         @char = char
         @paginator = paginator
         super File.dirname(__FILE__) + "/comps.erb"
      end

    end
  end
end
