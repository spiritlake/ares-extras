module AresMUSH
  class Character < Ohm::Model
    collection :cortex_skills, "AresMUSH::CortexSkill"
    collection :cortex_attributes, "AresMUSH::CortexAttribute"
    collection :cortex_assets, "AresMUSH::CortexAsset"
    collection :cortex_complications, "AresMUSH::CortexComplication"
    
    attribute :cortex_advance_points, :type => DataType::Integer
    attribute :cortex_plot_points, :type => DataType::Integer

    before_delete :delete_cortex_abilities
    
    def delete_cortex_abilities
      [ self.cortex_skills, self.cortex_attributes, self.cortex_assets, self.cortex_complications ].each do |list|
        list.each do |a|
          a.delete
        end
      end
    end
  end
  
  class CortexSkill < Ohm::Model
    include ObjectModel
    
    attribute :name
    attribute :die_step
    reference :character, "AresMUSH::Character"
    attribute :specialties, :type => DataType::Hash, :default => {}
    index :name
    
    
  end
  
  class CortexAttribute < Ohm::Model
    include ObjectModel
    
    attribute :name
    attribute :die_step
    reference :character, "AresMUSH::Character"
    index :name
  end
  
  class CortexAsset < Ohm::Model
    include ObjectModel
    
    attribute :name
    attribute :die_step
    reference :character, "AresMUSH::Character"
    index :name
  end
  
  class CortexComplication < Ohm::Model
    include ObjectModel
    
    attribute :name
    attribute :die_step
    reference :character, "AresMUSH::Character"
    index :name
  end
  
end