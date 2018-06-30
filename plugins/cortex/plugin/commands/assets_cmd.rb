module AresMUSH    
  module Cortex
    class AssetsCmd
      include CommandHandler
  
      def handle
      
        assets = Global.read_config("cortex", "assets")
        list = assets.sort_by { |a| a['name']}
                    .map { |a| format_asset(a) }
                    
        template = BorderedPagedListTemplate.new list, cmd.page, 25, t('cortex.assets_title')
        client.emit template.render
      end
      
      def format_asset(asset)
        steps = asset['steps'] ? asset['steps'].join(', ') : "d2+"
        name = asset['name'].ljust(25)
        desc = asset['description']
        
        "%xh#{name}%xn #{steps.ljust(15)} #{desc} "
      end
    end
  end
end