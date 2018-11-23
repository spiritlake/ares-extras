---
toc: FFG Skills
summary: Managing FFG skills.
---

# Managing FFG

Admin can set abilities manually and award story and experience points.

> Note:  Since the effects of talents are not coded, you may need to use these commands to manually adjust abilities after people purchase certain talents.

`xp/award <name>=<points>` - Awards experience points to a character.
`story/award <name>=<points>` - Awards story points to a character.

`characteristic/set <name>=<ability name>/<rating>` - Sets a characteristic.
`skill/set <name>=<ability name>/<rating>` - Sets a skill.
`talent/add <name>=<talent name>` - Adds a talent.
`talent/remove <name>=<talent name>` - Removes a talent.

`force/set <name>=<force rating>` - Sets someone's force rating.
`wounds/set <name>=<wounds>` - Sets someone's wound level.
`strain/set <name>=<wounds>` - Sets someone's strain level.
`woundthresh/set <name>=<wound thresh>` - Sets someone's wound threshold.  (Some talents affect this.)
`strainthresh/set <name>=<strain thresh>` - Sets someone's strain threshold.  (Some talents affect this.)

Set a rating to 0 to remove an ability.