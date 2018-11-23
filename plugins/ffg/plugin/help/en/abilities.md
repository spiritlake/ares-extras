---
toc: FFG Skills
summary: Setting abilities.
aliases:
- talent
- characteristic
- skill
---

# FFG Abilities

FFG has three kinds of abilities:  Characteristics, Skills and Talents.  You buy these with XP, though certain careers and archetypes may give you certain abilities for free.

* **Characteristics** represent basic abilities all characters possess.  They're rated from 1-5, with 2 representing average human ability.
* **Skills** represent training and knowledge.  They're also rated from 1-5, with 2 representing basic competence.
* **Talents** are special abilities or tricks that a character can use to do cool feats.  Some talents are rated from 1-5; others you either have or don't have.

> Note: Talents use the FFG Gensys model of a 'balanced' talent pyramid instead of the talent tree.  To purchase a tier/rating 2 talent, you must first have **two** tier/rating 1 talents beneath it.  To purchase a tier/rating 3 talent, you must first have **three** tier/rating 2 talents beneath it, and so on.

`charac` - Lists characteristics.
`charac/set <name>=<rating>` - Sets a characteristic.

`skills` - Lists skills.
`skill/set <name>=<rating>` - Sets a skill.

`talents` - Lists talents.
`talents/spec <specialization>` - Lists only talents that are available to a given specialization.
`talent/add <name>` - Adds a talent.  Adding a ranked talent more than once increases its rank.
`talent/remove <name>` - Removes a talent.  Removing a ranked talent decreases its rank.
