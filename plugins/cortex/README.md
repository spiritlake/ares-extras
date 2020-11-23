# Cortex

## Status

**Supported**  Although not part of the main Ares code release, this is a supported plugin.  [Report](https://aresmush.com/feedback) any problems you encounter.

Designed for AresMUSH 1.0.

> Note: This code has been run through its paces on a test server, but hasn't been playtested on a real game yet.   The first game to implement this will receive extra technical support from Faraday to iron out any bugs.

## Overview

This game uses a simplified implementation of the [Cortex System](https://boardgamegeek.com/rpgsystem/2044/cortex-classic) used in the Firefly and Leverage RPGs.

    +==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+
    Character Sheet for Carter
    
    -----[ Attributes ]-----------------------------------------------------------
    Agility:        d12+d4              Strength:       d8                  
    Vitality:       d6                  Willpower:      d4                  
    
    -----[ Skills ]---------------------------------------------------------------
    Athletics:      d6      Running:d8
    Guns:           d6      Pistols:d12, Rifles:d8
    Melee Weapons:  d4      
    Unarmed Combat: d6      Tae Kwon Do:d12
    
    -----[ Assets ]---------------------------------------------------------------
    Ambidextrous:   d2                  Blue Blood:     d4                  
    Steady Calm:    d8                  
    
    -----[ Complications ]--------------------------------------------------------
    Allergy:        d8                  
    
    -----[ Derived Attributes ]---------------------------------------------------
    Endurance:      d4+d6               Resistance:     d6+d6               
    Initiative:     d12+d4              
    
    Plot Points:    0                   Life Points:    10                  
    Advance Points: 4                   
    +==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+

The design of this plugin is described in detail in the [Create Plugin Tutorial](https://aresmush.com/tutorials/code/create-plugin/).

## Web Portal

This plugin has no web portal component.

## Installation

1. Disable the FS3 plugins, as explained in [Enabling and Disabling Plugins](https://aresmush.com/tutorials/config/plugins/).
2. In the game, run `plugin/install cortex`.
3. Go to Admin->Setup and change your [chargen stages](https://aresmush.com/tutorials/config/chargen.html).  Replace the FS3 stage with stages for FFG:

Old:

    abilities:
      help: skills

New:

    cortex:
      help: cortex
    abilities:
      help: abilities

Additional configuration options are described below.

## Configuration

This plugin has several configuration options:

### Starting Points

You can configure how many attribute, skill and trait points are allowed in chargen.

* `starting_attribute_points`
* `starting_skill_points`
* `starting_trait_points`

### Starting Steps

You can configure the maximum die step allowed for different ability types in chargen.

* `max_attribute_step`
* `max_specialty_skill_step`
* `max_complication_step`
* `max_asset_step`

### Derived Stats

You can configure which stats are used to calculate the derived stats.  For example:

    initiative: 
        - Agility
        - Alertness

### Abilities

There are config files for each of assets, attributes, complications and skills.  You can configure the list of abilities.  For example:

    skills:
    - 
      name: Animals
      description: Training and caring for animals.
      specialties: Riding, Zoology, Vet, Trainer
    - 
      name: Artistry
      description: Creative expression.
      specialties: Cooking, Composition, Painting, Photography, Sculpture, Writing

A couple notes:  

* Skill specialties are a free-form text string, not a fixed list.
* Assets and complications may specify the list of available steps.  Otherwise all steps are permitted.

## Uninstalling

Removing the plugin requires some code fiddling.  See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).