# Ffg

## Status

**Supported**  Although not part of the main Ares code release, this is a supported plugin.  [Report](https://aresmush.com/feedback) any problems you encounter.

Designed for AresMUSH 1.0.

> Note: This code has been run through its paces on a test server, but hasn't been playtested on a real game yet.   The first game to implement this will receive extra technical support from Faraday to iron out any bugs.

## Overview

This plugin is a simplified implementation of the [Fantasy Flight Games System](https://www.fantasyflightgames.com/en/index/), used in the generic Genesys system and the various Star Wars RPGs (Edge of Empire, Age of Rebellion and Force and Destiny).  

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


## Implementation Notes

This system is based upon the Genesys rules.  The simplified talents trees and careers in Genesys allow you to set up your own setting more easily, and are better-suited for a MUSH environment.

### Genesys vs Star Wars

The two big differences between Genesys and FFG Star Wars:

* Genesys uses a "talent pyramid" instead of a maze-like talent tree.  In order to buy a tier 2 talent (or a second rank in a tier 1 talent), 
* Genesys does not use career specializations, and instead just gives people more career skills out of the gate.

Given the popularity of FFG Star Wars, an effort was made to incorporate force powers and specializations into the Genesys rules.  It's not a perfect model.  Star Wars characters will not get talents in exactly the same order or at the same cost compared to the classic FFG Star Wars rules.  Force Powers are treated as talents, so their costs work out a tiny bit different too.

> If somebody wants to code a more 'pure' representation, they're welcome to build on this code and submit a Star Wars-specific plugin.

### General Notes

A few other miscellaneous notes:

* Talents have no coded effects.  You'll have to make adjustments manually.
* Instead of giving people "4 free career skills", this plugin gives them 20 extra XP to buy them, and makes sure they've bought at least 4 career skills during app review.  If you're using specializations, you can make this 30 to include their 2 free specialization skills.
* You can also give people extra XP on top of that to let them start out more advanced.  There are no restrictions on how this XP can be spent.

### Configuring Another Setting

The `sw-rebellion` folder contains a pre-built configuration for Star Wars Age of Rebellion.  If you want to convert another Star Wars setting, here are a few tips:

* If a talent appears in more than one talent tree, use the _lowest_ place it appears to determine the cost.
* If a species/archetype gets some extra skills (like Humans getting 2 free non-career skills) just give them extra XP instead.

## Installation

1. Connect to the [server shell](https://aresmush.com/tutorials/code/extras/) and change to the aresmush directory.
2. Run `bin/addplugin ffg`.
3. Disable the FS3 plugins, as expplained in [Enabling and Disabling Plugins](https://aresmush.com/tutorials/config/plugins/).
4. Type `load ffg` in-game.

> Note:  The default configuration is for the generic Genesys setting.  If you want to use Star Wars Age of Rebellion, copy the files from `/tmp/ares-extras/plugins/ffg/sw-rebellion` to your `aresmush/game` directory or copy/paste the configuration from those files using the advanced config editor.

## Setting Up App Review

You have to make a change to the Chargen plugin to make it display the cortex ability status in the `app` command.

In `aresmush/plugins/chargen/templates/app.erb`, add:

    <%= section_title(t('chargen.abilities_review_title')) %>
    <%= ffg_abilities %> 

In `aresmush/plugins/chargen/templates/app_template.rb`, add:

      def ffg_abilities
        Ffg.app_review(@char)
      end

Type `load chargen` in-game when finished.

## Configuration

This plugin has several configuration options, explained below.

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

## Web Portal

This plugin has no web portal component.
