module AresMUSH
  module Prefs
    class PrefsTemplate < ErbTemplateRenderer
            
      attr_accessor :char
      
      def initialize(char)
        @char = char
        super File.dirname(__FILE__) + "/prefs.erb"
      end
      
      def name
        @char.name
      end
      
      def positive
        @char.prefs.select { |k, v| v['setting'] == '+' }.sort
      end
      
      def negative
        @char.prefs.select { |k, v| v['setting'] == '-' }.sort
      end
      
      def maybe
        @char.prefs.select { |k, v| v['setting'] == '~' }.sort
      end
      
      def note(data)
        return data['note']
      end
      
      def setting(data)
        setting = data['setting']
        case setting
        when "+"
          return "%xg+%xn"
        when "-"
          return "%xr-%xn"
        else
          return "%xy~%xn"
        end
      end
    end
  end
end
