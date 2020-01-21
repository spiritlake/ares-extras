# Scene Dice Roller

This snippet outlines how to add a "Roll Dice" option to the "Play" menu in web scenes.  This may be useful for games that aren't using a specific skill system and just want a way to roll some dice.  It can also be a roadmap to implementing a "Roll Skill" button for your own custom skill system.

## Live Scene Custom Component Template

In `ares-webportal/app/templates/components/live-scene-custom-play.hbs`, add a menu button and a popup window that will be toggled visible when the menu is clicked.

[Full code](live-scene-custom-play.hbs).

## Live Scene Custom Component Javascript

In `ares-webportal/app/templates/components/live-scene-custom-play.hbs`, add a click handler for our menu button.  

[Full code](live-scene-custom-play.hbs).

## Web Request Handler and Dispatcher

There's already a web request handler for the die roller in `aresmush/plugins/utils/web/roll_dice_handler.rb`.  [View Code](https://github.com/AresMUSH/aresmush/blob/master/plugins/utils/utils.rb#L76)

There's also wiring to connect the `rollDice` web request to the web request handler.  [View Code](https://github.com/AresMUSH/aresmush/blob/master/plugins/utils/web/roll_dice_handler.rb)

* If you're just using the `dice` command roller, you don't need to do anything further.
* If you're making your own custom roller, you can use these files as a model and make your own web request handler and dispatcher.