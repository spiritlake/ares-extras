# RP Preferences

## Status

**Supported** Although not part of the main Ares code release, this is a supported plugin.  Report any problems you encounter: https://aresmush.com/feedback

Designed for AresMUSH 1.0

## Overview

The RP preferences system provides a way to record RP preferences in a yes/no/maybe fashion with detailed notes.  You can view preferences:

    +==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+
    RP Preferences for Mary
    
    -----  +  --------------------------------------------------------------------
    Adventure       More!
    
    -----  ~  --------------------------------------------------------------------
    Intrigue
    
    -----  -  --------------------------------------------------------------------
    Politics        Ugh.
    
    ------------------------------------------------------------------------------

And find players with specific preferences. 

    +==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+
    RP Preferences - Adventure
    -----  +  --------------------------------------------------------------------
    Mary            More!
    John          
    +==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+

## Web Portal

This plugin has no web portal component.

## Installation

In the game, run `plugin/install prefs`.

See additional setup instructions below.

## Configuration

Once installed, go to the web portal setup screen.  Edit `prefs.yml` and you can configure the following setings.

## categories

You can configure the list of categories that players can set a preference for.

## Uninstalling

Removing the plugin requires some code fiddling.  See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).