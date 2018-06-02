# Wikidot Integration

## Status

**Deprecated**.  May require tweaking to get it to work with the current Ares code.

Designed for AresMUSH 0.4

## Overview

[Wikidot](http://www.wikidot.com/) is a great free wiki hosting solution.  This plugin integrates with wikidot to help you create scenes and character pages.

I ultimately discarded it because the web portal now has a self-contained wiki that does all of this automatically.  I've left the code here as a reference for anyone who's really in love with wikidot.  

## Sharing Modes

The plugin supports two modes - automatic and manual sharing.

Automatic sharing requires a Wikidot "Pro" plan.  You have to enable the API access in your wikidot site configuration.  See the Wikidot documentation for details.  Once you do that, though, the game can post scenes and character pages to the wiki on its own.

Manual sharing just spits out wiki code on the game screen that you have to copy/paste to the wiki.

## Installation

1. Copy the `wikidot` folder to your game's `plugins` folder.
2. Move the `wikidot.yml` file to the `game/config` folder.

## Configuration

You'll need to add this entry to your Gemfile to include the wikidot api.

    gem 'wikidot-api', '~> 0.0.6'

And in `aresmush.rb` in the require list add:

    require "wikidot_api"

Then you'll need to add another entry to your `secrets.yml` file for the wikidot API key.

    secrets:
      wikidot:
        api_key: wv0kuheA05jdmze7qTW0Q6nHBkiS7zJg

If you want scenes to be automatically posted to wikidot when they're shared, you can add this code to the share scene command:

    Wikidot.create_log(scene, client, false)
