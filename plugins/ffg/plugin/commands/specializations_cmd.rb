module AresMUSH    
  module Ffg
    class SpecializationsCmd
      include CommandHandler
  
      def handle
        types = Global.read_config("ffg", "specializations")
        list = types.sort_by { |a| a['name']}
        template = SpecializationsTemplate.new list
        client.emit template.render
      end
    end
  end
end