# FFG

## Status

**Supported**  Although not part of the main Ares code release, this is a supported plugin.  [Report](https://aresmush.com/feedback) any problems you encounter.

Designed for AresMUSH 1.0.

## Overview

This plugin is a simplified implementation of the [Fantasy Flight Games RPG](https://www.fantasyflightgames.com/en/index/).  It is primarily based on their generic Genesys system, but it does incorporate a few things from the various Star Wars RPGs (Edge of Empire, Age of Rebellion and Force and Destiny).  

    +==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+
    Character Sheet for Neela 
    Laborer/Soldier
    
    -----[ Characteristics ]------------------------------------------------------
    Agility:        3                   Brawn:          3                   
    Cunning:        2                   Intellect:      2                   
    Presence:       2                   Willpower:      1                   
    
    -----[ Skills ]---------------------------------------------------------------
    Athletics:      1                   Brawl:          1                   
    Melee:          2                   
    
    -----[ Talents ]--------------------------------------------------------------
    Berserk                             Dodge (2)                           
    Grit (2)                            Rapid Reaction (1)                  
    
    -----[ Other ]----------------------------------------------------------------
    Experience:     5                   Story Points:   0                   
    Strain Thresh:  9                   Wound Thresh:   15                  
    Force Rating:   0                   
    +==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+

    %% Faraday rolls Melee and is successful. (A A A S) Advantage (3) 
    
    %% Faraday rolls Melee+3S and fails. (- A F F S T) 

## Web Portal

This plugin has no web portal component.  Nor is it ever likely to, given its complexity.

## Installation

1. Disable the FS3 plugins, as explained in [Enabling and Disabling Plugins](https://aresmush.com/tutorials/config/plugins/).
2. In the game, run `plugin/install ffg`.
3. Go to Admin->Setup and change your [chargen stages](https://aresmush.com/tutorials/config/chargen.html).  Replace the FS3 stage with stages for FFG:

Old:

    abilities:
      help: skills

New:

    ffg:
      help: ffg
    abilities:
      help: abilities

See additional setup instructions below.

## Implementation Notes

This system is based upon the Genesys rules.  The simplified talents trees and careers in Genesys allow you to set up your own setting more easily, and are better-suited for a MUSH environment.

Given the popularity of FFG Star Wars, an effort was made to incorporate force powers and career specializations into the Genesys rules.  It's not a perfect model.  Star Wars characters will not get talents in exactly the same order or at the same cost compared to the classic FFG Star Wars rules.  Force Powers are treated as talents, so their costs work out a tiny bit different too.

> If somebody wants to code a more 'pure' representation, they're welcome to build on this code and submit a Star Wars-specific plugin.

### Talent Pyramid

The talent pyramid in Genesys ensures that people don't max out a single talent.  You always have to have more talents at lower tiers to balance ones at higher tiers.  For example:

Mary has Grit(2), Dodge(1).  This talent tree IS balanced, because tier 1 has more talents than tier 2.

     Tier 2: -
     Tier 1: - -

Bob has Grit(3), Dodge(3), Reaction (2).  This talent tree is NOT balanced.  Tier 2 has the same number talents than tier 1.  That's not allowed.

     Tier 3: - -
     Tier 2: - - -
     Tier 1: - - -

To make Bob's talent tree balanced, he would need to have an additional talent at tier 1.

     Tier 3: - -
     Tier 2: - - -
     Tier 1: - - - -

### General Notes

A few other miscellaneous notes:

* Talents have no coded effects.  You'll have to make adjustments manually.
* Instead of giving people "4 free career skills", this plugin gives them 20 extra XP to buy them, and makes sure they've bought at least 4 career skills during app review.  If you're using specializations, you can make this 30 to include their 2 free specialization skills.
* You can also give people extra XP on top of that to let them start out more advanced.  There are no restrictions on how this XP can be spent.

## Configuration

This plugin has several configuration options, explained below.

### Using the Star Wars Configurations

The default configuration is for the generic Genesys setting.  A set of configuration files is also available for Star Wars: Age of Rebellion and (thanks to Xango@ChontioMUSH) Star Wars: Edge of Empire. To use either of the the Star Wars configurations:

1. Get the raw config files from GitHub: https://github.com/AresMUSH/ares-extras/tree/master/plugins/ffg/sw-rebellion or https://github.com/AresMUSH/ares-extras/tree/master/plugins/ffg/sw-eote.
2. In the web portal, go to Admin -> Setup.
3. One by one, edit each config file.  Use the Advanced Editor mode so you can copy/paste the whole file at once.

Alternately, you can download the files and FTP them to your `aresmush/game/config` directory.

> Note:  You can only use one set of configuration files at a time.

### Configuring Other Star Wars Games

The `sw-rebellion` config described above contains a pre-built configuration for Star Wars Age of Rebellion (AoR).  Some compromises had to be made when converting the complex talent trees from AoR to the more simplistic Genesys model.  Here's how it works:

1. For each talent, find the **lowest cost** it appears in any talent tree.  For example:  Grit costs 5XP for a Gunner and 10XP for a Driver.  The lowest cost is 5XP.  This determines the **tier** (tier 1 = 5XP, tier 2 = 10XP, etc.)
2. If a talent appears multiple times in anyone's talent tree at different costs, it's considered a **ranked** talent.  For example:  Gunner has the Durable talent at both 5XP and 15XP, so that is treated as a ranked talent.
3. If a talent can only be purchased by force users, it's considered a force talent.
4. Force powers are also converted into talents, with tiers based on their costs.

Obviously this loses some of the nuance inherent in the talent trees.  The aforementioned Driver can now buy Grit at 5XP instead of 10.  The Gunner can buy Durable at every rank, instead of just 5 / 15.  You may want to fudge the cost of certain talents or impose manual limits for game balance.

Also worth noting:  If a species/archetype gets some extra skills (like Humans getting 2 free non-career skills) just give them extra XP instead.

### Experience Points

You can configure how many extra XP (on top of the archetype starting XP) people get in chargen.

* `bonus_xp`
* `career_skill_xp`

### Chargen Ratings

You can configure the maximum starting ratings required in chargen.

* `max_cg_skill_rating`
* `max_cg_characteristic_rating`

### Miscellaneous

* `min_career_skills` - How many career skills everyone must start with.
* `wound_characteristic` - The characteristic used for calculating wound threshold.  Brawn by default.
* `strain_characteristic` - The characteristic used for calculating strain threshold.  Willpower by default.
* `use_force` - Set to 'true' if you're a Star Wars game to make force rating and force information appear.

### Archetypes

You can configure the list of available archetypes.  For each archetype, you can set the name, starting characteristics, starting wound/strain thresholds, starting XP, and any skills or talents they start with for free.

    ffg:
        archetypes:
            -
                name: Human
                characteristics:
                    Brawn: 2
                    Agility: 2
                    Intellect: 2
                    Cunning: 2
                    Willpower: 2
                    Presence: 2
                wound: 10
                strain: 10
                xp: 100
                skills: []
                talents: []

### Careers

You can configure the list of available careers and their associated career skills.

    ffg:
        careers:
            - 
                name: Entertainer
                career_skills:
                    - Charm
                    - Coordination
                    - Deception
                    - Discipline
                    - Leadership
                    - Melee
                    - Skulduggery
                    - Stealth

### Specializations

Specializations are optional.  The FFG Star Wars system uses them but Genesys doesn't.  To use specializations, you can configure the name and career skills.  Specialization config includes:

* Career skills - A list of skills you get the career skill discount for.
* Career - The career associated with this specialization.  Leave this blank for universal specializations.
* Force User - Set this to true if this specialization enables someone to get force powers.

-

    ffg:
        specializations:
        -
            name: Slicer
            career_skills:
            - Composure
            - Knowledge
            - Stealth
            career: Spy

### Characteristics

You can configure the list of characteristics, including a name and description.

    ffg:
        characteristics:
            - 
                name: Agility
                description: "Dexterity, hand-eye coordination, body control."

### Skills

You can configure the list of available skills.  For each skill, you can specify a name, description, and the characteristic used when rolling that skill.

    ffg:
        skills:
            - 
                name: Athletics
                description: "General fitness and tasks like running, climbing, etc."
                characteristic: Brawn


### Talents

You can configure the list of available talents.  

> Note: The talent system implemented by this plugin is a blend of the Genesys and Star Wars systems.  See the implementation notes above for details.

Talent configuration includes:

* Tier - Set this to 1-5 for the talent tier.
* Ranked - Set this to true if the talent can be purchased multiple times at different ranks, false if it can only be purchased once.
* Max_Rank - Optionally set this to limit the talent's maximum rank.  If not set, the max rank is 5.  Only applies to ranked talents.
* Prereq - Optionally list a talent the character has to have before they can purchase this one.
* Specializations - Optionally list a specizalization the character has to have before they can purchase this one.
* Force_power - Set this to true if this is a force power talent.  Only characters with force user specializations can purchase force powers.

-

    ffg:
        talents: 
            -
                name: Improved Overcharge
                tier: 5
                ranked: false
                prereq: Overcharge
            - 
                name: Sniper Shot
                tier: 1
                ranked: true
                specializations:
                    - Sharpshooter

## Uninstalling

Removing the plugin requires some code fiddling.  See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).