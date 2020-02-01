module AresMUSH
  module Fate
    
    def self.get_web_sheet(char, viewer)
      {
        aspects: (char.fate_aspects || []).map { |a| Website.format_markdown_for_html(a) },
        stunts: (char.fate_stunts || {}).sort.map { |k, v| {
          name: k,
          desc: v
        }},
        skills: (char.fate_skills || {}).sort.map { |k, v| {
          name: k,
          rating: v,
          rating_name: Fate.rating_name(v)
        }}
      }
    end
    
  end
end