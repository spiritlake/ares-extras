module AresMUSH    
  module Cortex
    class ComplicationsCmd
      include CommandHandler
  
      def handle
        complications = Global.read_config("cortex", "complications")
        list = complications.sort_by { |a| a['name']}
                    .map { |a| format_asset(a) }
                    
        template = BorderedPagedListTemplate.new list, cmd.page, 25, t('cortex.complications_title')
        client.emit template.render
      end
      
      def format_asset(complication)
        steps = complication['steps'] ? complication['steps'].join(', ') : "d2+"
        name = complication['name'].ljust(25)
        desc = complication['description']
        
        "%xh#{name}%xn #{steps.ljust(15)} #{desc} "
      end
    end
  end
end