module AresMUSH    
  module Cortex
    class SkillsCmd
      include CommandHandler
  
      def handle
        skills = Global.read_config("cortex", "skills")
        list = skills.sort_by { |a| a['name']}
                  .map { |a| "%xh#{a['name'].ljust(15)}%xn #{a['description']} (#{a['specialties']})"}
                    
        template = BorderedPagedListTemplate.new list, cmd.page, 25, t('cortex.skills_title')
        client.emit template.render
      end
    end
  end
end