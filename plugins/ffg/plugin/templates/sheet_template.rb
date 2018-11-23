module AresMUSH    
  module Ffg
    class SheetTemplate < ErbTemplateRenderer
      attr_accessor :char
  
      def initialize(char)
        @char = char
        super File.dirname(__FILE__) + "/sheet.erb"
      end
      
      def summary
        summ = "#{char.ffg_archetype}"
        if (char.ffg_career)
          summ << "/#{char.ffg_career}"
        end
        if (char.ffg_specializations && char.ffg_specializations.any?)
          summ << " (#{char.ffg_specializations.join(', ')})"
        end
        summ
      end
      
      def talents
        @char.ffg_talents.to_a.sort_by { |a| a.name }
          .each_with_index
            .map do |a, i| 
              linebreak = i % 2 == 0 ? "\n" : ""
              title = a.name
              rating = a.ranked ? " (#{a.rating})" : ''
              display = left("#{title}#{rating}", 36)
              "#{linebreak}#{display}"
            end
      end
  
      def characteristics
        format_two_per_line @char.ffg_characteristics
      end
      
      def skills
        format_two_per_line @char.ffg_skills
      end
      
      def strain
        format_bar(@char.ffg_strain, @char.ffg_strain_threshold)
      end
      
      def wounds
        format_bar(@char.ffg_wounds, @char.ffg_wound_threshold)
      end
      
      def format_bar(current, max)
        current = current || 0
        max = max || 10
        x = current.times.map { |i| 'X' }.join
        o = (max - current).times.map { |i| 'o' }.join
        "#{x}#{o} (#{current}/#{max})"
      end
      
      def format_two_per_line(list)
        list.to_a.sort_by { |a| a.name }
          .each_with_index
            .map do |a, i| 
              linebreak = i % 2 == 0 ? "\n" : ""
              title = left("#{ a.name }:", 15)
              rating = left(a.rating, 20)
              "#{linebreak}%xh#{title}%xn #{rating}"
        end
      end
    end
  end
end