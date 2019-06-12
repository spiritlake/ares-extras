$:.unshift File.dirname(__FILE__)

module AresMUSH
     module Cortex

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("cortex", "shortcuts")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "attribute"
        if (cmd.switch_is?("set"))
          return AttributeSetCmd
        else
          return AttributesCmd
        end
      when "skill"
        if (cmd.switch_is?("set"))
          return SkillSetCmd
        elsif (cmd.switch_is?("specialty"))
          return SkillSpecialtyCmd
        else
          return SkillsCmd
        end
      when "asset"
        if (cmd.switch_is?("set"))
          return AssetSetCmd
        else
          return AssetsCmd
        end
      when "complication"
        if (cmd.switch_is?("set"))
          return ComplicationSetCmd
        else
          return ComplicationsCmd
        end
      when "sheet"
        return SheetCmd
      when "reset"
        return ResetCmd
      when "roll"
        return RollCmd
      when "advance"
        if (cmd.switch_is?("award"))
          return AdvancementPointAwardCmd
        end
      when "plotpoints"
        if (cmd.switch_is?("award"))
          return PlotPointAwardCmd
        elsif (cmd.switch_is?("spend"))
          return PlotPointSpendCmd
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
