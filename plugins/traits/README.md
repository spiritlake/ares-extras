# Simple Traits

## Status

**Supported** Although not part of the main Ares code release, this is a supported plugin.  Report any problems you encounter: https://aresmush.com/feedback

Designed for AresMUSH 1.0

> Note: This code has been run through its paces on a test server, but hasn't been playtested much on a real game yet.   The first game to implement this will receive extra technical support from Faraday to iron out any bugs.

## Overview

The traits system provides a simple way to store character stats with a name/description, as one might find on comic games.

    +==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+
    Traits - Steve
    
    ------------------------------------------------------------------------------
    Shield
    Cap has a super shield.
    ------------------------------------------------------------------------------
    Strong
    Cap is very strong.
    +==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+

## Web Portal

The plugin includes web portal controls to set traits during chargen and view them on a character profile.

## Installation

1. Unless you are planning to use traits in conjunction with FS3, you probably want to disable the FS3 plugins, as explained in [Enabling and Disabling Plugins](https://aresmush.com/tutorials/config/plugins/).
2. In the game, run `plugin/install traits`.
3. Go to Admin->Setup and change your [chargen stages](https://aresmush.com/tutorials/config/chargen.html).  Replace the FS3 stages with a stage for traits:

Old:

    stages:
      sheet:
        help: sheets
      ...
      abilities:
        help: skills

New:

    stages:
      ...
      traits:
        help: traits

## Configuration

Configuration options can be found in game/config/traits.yml.

`traits_blurb` - The instructions that appear above the traits web chargen controls.

Note: If you are using _just_ traits (without any other skills system), you probably want to alias the 'sheet' command to 'traits'.  You can do this by editing the shortcuts config in the `traits.yml` config file.

    ---
    custom:
      shortcuts:
          sheet: traits

## Uninstalling

Removing the plugin requires some code fiddling.  See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).