$:.unshift File.dirname(__FILE__)

module AresMUSH
     module Ffg

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("ffg", "shortcuts")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "archetype"
        if (cmd.switch_is?("set"))
          return ArchetypeSetCmd
        else
          return ArchetypesCmd
        end
      when "characteristic"
        if (cmd.switch_is?("set"))
          return CharacteristicSetCmd
        else
          return CharacteristicsCmd
        end
      when "skill"
        if (cmd.switch_is?("set"))
          return SkillSetCmd
        else
          return SkillsCmd
        end
      when "specialization"
        if (cmd.switch_is?("add"))
          return SpecAddCmd
        elsif (cmd.switch_is?("remove"))
          return SpecRemoveCmd
        end
      when "talent"
        if (cmd.switch_is?("add"))
          return TalentAddCmd
        elsif (cmd.switch_is?("remove"))
          return TalentRemoveCmd
        else
          return TalentsCmd
        end
      when "career"
        if (cmd.switch_is?("set"))
          return CareerSetCmd
        else
          return CareersCmd
        end
      when "sheet"
        return SheetCmd
      when "roll"
        return RollCmd
      when "xp"
        if (cmd.switch_is?("award"))
          return XpAwardCmd
        end
      when "destiny"
        if (cmd.switch_is?("award"))
          return DestinyPointAwardCmd
        elsif (cmd.switch_is?("spend"))
          return DestinyPointSpendCmd
        end
      end
      return nil
    end

    def self.get_event_handler(event_name)
      nil
    end

    def self.get_web_request_handler(request)
      nil
    end

  end
end
