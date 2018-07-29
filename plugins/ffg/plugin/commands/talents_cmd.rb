module AresMUSH    
  module Ffg
    class TalentsCmd
      include CommandHandler
  
      def handle    
        talents = Global.read_config("ffg", "talents").sort_by { |t| [ t['tier'], t['name'] ]}
        paginator = Paginator.paginate(talents, cmd.page, 25)
        template = TalentsTemplate.new(paginator)
        client.emit template.render
      end
    end
  end
end