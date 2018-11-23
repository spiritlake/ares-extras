module AresMUSH
  module Ffg
    describe Ffg do 
      
      before do
        stub_translate_for_testing
      end      

      describe :can_change_specs? do
        before do 
          @char = double
          allow(@char).to receive(:is_approved?) { false }
          allow(@char).to receive(:ffg_archetype) { "Worker" }
          allow(@char).to receive(:ffg_skills) { [] }
          allow(@char).to receive(:ffg_talents) { [] }
          allow(Ffg).to receive(:find_archetype_config).with("Worker") { { 'skills' => [ 'Firearms' ], 'talents' => [ 'Special' ] }}
        end
        
        it "should allow them if they're approved" do
          allow(@char).to receive(:is_approved?) { true }
          expect(Ffg.can_change_specs?(@char)).to eq true
        end
        
        it "should NOT allow them if they haven't set their archetype" do
          allow(@char).to receive(:ffg_archetype) { nil }
          expect(Ffg.can_change_specs?(@char)).to eq false
        end

        it "should allow them if their archetype gave them a special skill and that's all they have" do
          allow(@char).to receive(:ffg_skills) { [FfgSkill.new(rating: 1, name: "Firearms")] }
          expect(Ffg.can_change_specs?(@char)).to eq true
        end

        it "should NOT allow them if their archetype gave them a special skill and they have more ratings in it" do
          allow(@char).to receive(:ffg_skills) { [FfgSkill.new(rating: 2, name: "Firearms")] }
          expect(Ffg.can_change_specs?(@char)).to eq false
        end

        it "should NOT allow them if they have other skills" do
          allow(@char).to receive(:ffg_skills) { [FfgSkill.new(rating: 1, name: "Firearms"), FfgSkill.new(rating: 1, name: "Melee")] }
          expect(Ffg.can_change_specs?(@char)).to eq false
        end
        
        it "should allow them if their archetype gave them a special talent and that's all they have" do
          allow(@char).to receive(:ffg_talents) { [FfgTalent.new(rating: 1, name: "Special")] }
          expect(Ffg.can_change_specs?(@char)).to eq true
        end

        it "should NOT allow them if their archetype gave them a special talent and they have more ratings in it" do
          allow(@char).to receive(:ffg_talents) { [FfgTalent.new(rating: 2, name: "Special")] }
          expect(Ffg.can_change_specs?(@char)).to eq false
        end

        it "should NOT allow them if they have other talents" do
          allow(@char).to receive(:ffg_talents) { [FfgTalent.new(rating: 1, name: "Special"), FfgTalent.new(rating: 1, name: "Awesome")] }
          expect(Ffg.can_change_specs?(@char)).to eq false
        end


      end
    end
  end
end

        
