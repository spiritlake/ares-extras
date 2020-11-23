# Compliments

## Credits

Tat @ Ares Central

## Overview

This plugin allows players to give compliments to other players. Players can view each other's compliments.

    +============================================================================+
    ADELAIDE'S COMPLIMENTS
    
    From Nessie                                                       2019-08-30
    Here is a test compliment. Compliments can be as long or as short as people like
    - there is no character requirement or limit.
    
    -----[   page 1 of 1   ]------------------------------------------------------

## Web Portal

This plugin has no web portal code.  

## Installation

In the game, run `plugin/install compliments`.

Additional configuration options are described below.

## Configuration
Configuration options can be set in `compliments.yml`.
`give_luck` - By default, giving a compliment also gives a fraction of a luck point. If you're not using the FS3Skills plugin, disable this by setting `give_luck` to `false`.

`luck_amount` - You can configure how much luck each compliment gives. By default, a compliment gives 1/20th of a luck point.

`comp_scenes` - Choose whether to let players compliment all participants of a scene by using the scene number.

If you turn off comp'ing scenes or earning luck, you'll want to adjust the helpfile text.

###Comp Achievement
This plugin adds an achievement for giving comps. You'll want to add `comp: fa-hand-holding-heart` as a type to `/game/config/achievements.yml`

## Uninstalling

Removing the plugin requires some code fiddling.  See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).
