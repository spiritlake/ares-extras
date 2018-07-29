module AresMUSH    
  module Ffg
    class ArchetypesCmd
      include CommandHandler
  
      def handle
        types = Global.read_config("ffg", "archetypes")
        list = types.sort_by { |a| a['name']}
                  .map { |a| "%xh#{a['name'].ljust(15)}%xn #{characteristics(a)}"}
                    
        template = BorderedListTemplate.new list, t('ffg.archetypes_title')
        client.emit template.render
      end
      
      def characteristics(type_config)
        type_config['characteristics'].map { |name, rating| "#{name}:#{rating}"}.join(", ")
      end
    end
  end
end