module AresMUSH
  module Traits
    def self.save_char(char, chargen_data)
      traits = {}
      (chargen_data[:traits] || {}).each do |name, desc|
        traits[name.titlecase] = Website.format_input_for_mush(desc)
      end
      char.update(traits: traits)
      return []
    end
    
    def self.get_traits_for_web_viewing(char, viewer)
      char.traits.map { |name, desc| {
        name: name,
        desc: Website.format_markdown_for_html(desc)
      }}
    end
    
    def self.get_traits_for_web_editing(char, viewer)
      char.traits.map { |name, desc| {
        name: name,
        desc: Website.format_input_for_html(desc)
      }}
    end
  end
end