---
toc: FFG Skills
order: 1
summary: The Cortex RPG system.
aliases:
- career
- archetype
- specialization
- spec
- reset
---

# FFG System

This game uses a simplified implementation of the [Fantasy Flight Games System](https://www.fantasyflightgames.com/en/index/), used in the generic Genesys system and the various Star Wars RPGs (Edge of Empire, Age of Rebellion and Force and Destiny).

The FFG RPG system is copyright by Fantasy Flight Publishing.  You'll need a copy of the rulebook to get the full rules set and all of the talent effects.

## Archetypes, Careers and Specializations

Each character has an Archetype and Career, which reflect the core of who they are.  

**Archetypes** may represent races/species (Human/Wookie/Elf/Dwarf/etc.) or broad swaths of humanity (Laborer/Aristocrat/etc.), depending on the game setting.  Your archetype determined your starting characteristics (like whether you're strong or smart) and experience points (XP), which are used to buy other abilities.

**Careers** represent your job/role in the game (Warrior/Smuggler/Healer/etc.)  Your career lets you purchase certain career skills at a discounted XP cost.

Some games have **Specializations** within each career.  Your first career specialization is free, but additional specializations cost XP.  Specializations let you purchase additional career skills at a discounted XP cost, and may make certain talents available to you.  You can only choose specializations from within your career.  Certain "universal" specializations can be chosen by any career.

`archetypes` - Lists archetypes.
`careers` - Lists careers and specializations.
`reset <archetype>/<career>` - Sets your career and archetype.
    Note: Since costs, etc. are based on career/archetype, doing this will reset your character.

`specialization/add <name>` - Adds a specialization.
`specialization/remove <name>` - Removes a specialization.

> Note: Since specializations affect ability costs, changing them during character creation will require a reset.