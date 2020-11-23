# Cookies

## Status

**Supported** Although not part of the main Ares code release, this is a supported plugin.  Report any problems you encounter: https://aresmush.com/feedback

Designed for AresMUSH 1.0

## Overview

The cookies system allows you to give virtual cookies to players as a 'thank you' for RPing with them.  Cookies have no intrinsic value.  They have no coded purpose.  They don't do anything for you.  They're just a fun thing to collect and get achievements for.

    %% You give Susie a cookie.
    
    %% You have received 92 cookies.
    

## Web Portal

The plugin includes a new scene menu item to give cookies to everyone in a scene.

## Installation

In the game, run `plugin/install cookies`.

Additional configuration options are described below.

## Configuration

Once installed, go to the web portal setup screen.  Edit `cookies.yml` and you can configure the following setings.

## cookie_award_cron

The game will periodically tally and award cookies.  There is a cron job to control when this happens.  By default it does this every Friday night.  See the [Cron Job Tutorial](http://www.aresmush.com/tutorials/code/cron.html) for help if you want to change this.

## cookie_category

The system will post the top cookie earners to the forum.  You can configure which forum category this posts to.  Making it a forum that doesn't exist will effectively disable the cookie post.

## Uninstalling

Removing the plugin requires some code fiddling.  See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).