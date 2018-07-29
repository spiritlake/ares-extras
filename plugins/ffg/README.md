# Ffg

## Status

**Supported**  Although not part of the main Ares code release, this is a supported plugin.  [Report](https://aresmush.com/feedback) any problems you encounter.

Designed for AresMUSH 1.0.

> Note: This code has been run through its paces, but hasn't been playtested on a real game yet.  There might be some bugs.

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

## Implementation Notes

Some compromises were made when implementing this system - first to allow people to run both Star Wars games and non-Star Wars games, and second to simplify some things that would have been inordinantely difficult to implement in a MUSH setting.

> If somebody wants to spend the effort to code a more 'pure' representation, they're welcome to build on this code and submit a contribution or a SW-specific plugin.

### Talents

Talents use the Genesys model where you need to have a 'balanced' talent pyramid (as opposed to the Star Wars model where each specialization has its own maze-like talent tree).  In the balanced model, you need to always have more talents in a tier *below* before you can add one in the next tier.  This keeps people from just shooting straight up to tier 5.

> For example: Mary has "Know Somebody", a ranked tier 1 talent.  Before she can purchase it again (at tier 2) or purchase some other tier 2 talent, she needs to have **2** total tier 1 talents.

You can get about 90% approximation of the Star Wars talent trees by setting prerequisites and specialization requirements on talents.

### Starting XP

FFG allows you to start with 4 ranks in career skills for free, and 2 ranks in specialization skills for your first specialization (if your system is using specializations).  To reflect this, the plugin just lets you give people a blanket bonus of XP, and requires them to take a certain number of career skills.  

For example, setting `career_skill_xp` to 20 and `min_career_skills` to 4 effectively makes them buy 4 "free" career skills.

You can also give extra XP to let people start out ahead of the curve, via the `bonus_xp` parameter.  There are no restrictions on how this can be spent.  Staff review should ensure that people don't just crazily pump up characteristics.

### Force Powers

Since this is slanted heavily towards the Genesys generic skill system, Star Wars Force Powers aren't treated as a separate kind of ability, but just a special type of talent.

## Installation

1. Connect to the [server shell](https://aresmush.com/tutorials/code/extras/) and change to the aresmush directory.
2. Run `bin/addplugin ffg`.
3. Disable the FS3 plugins, as expplained in [Enabling and Disabling Plugins](https://aresmush.com/tutorials/config/plugins/).
4. Type `load ffg` in-game.

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

This plugin has several configuration options:

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
* `use_force` - Set to 'true' if you're a Star Wars game using force rating.

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
