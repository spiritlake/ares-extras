# Text System

## Credit
This plugin was originally coded by skew @ Ares Central, with a few updates and packaging by Tat @ Ares Central.

## Installation
In the game, run `plugin/install txt`.

### Page Command

This plugin references the default AresMUSH page command. If that is not installed, this won't work. Specifically, it uses the DND and page lock features. If a person is set DND or page locked, you cannot txt them!

See additional setup instructions below.

## Overview

A command designed to mimic real world texting. It sends texts from one person to multiple people.

It can send as a simple person-to-person emit (like pages), as a scene emit, or as a person-to-person emit that also logs to a scene.

Allows users to choose their text color, reply to their previous text, start new scenes with a text.

## Configuring

### Message format

The message format is contained in `/aresmush/plugins/txt/locales/local_en.yml`. There are two lines, in case you want to make sender and receiver see different things. By default, they are both set to: `%xh%xg<TXT>%xn (From %{sender}) -> %{recipients}%{message}`

This outputs as: `<TXT> From Skew -> (to Pikachu) Hello there!`

## Web Portal

In addition to the included web portal files, you'll want to add a line of code to `/app/templates/components/live-scene-control.hbs` if you want to enable texting from portal scenes.

Insert the following with the other pose buttons:

`{{live-scene-txt scenePose=scenePose scene=scene}}`

For example:

`{{#if (not scene.completed)}}
    {{live-scene-txt scenePose=scenePose scene=scene}}
    <button {{action 'addPose' 'setpose'}} class="btn btn-default">Add Scene Set</button>
    <button {{action 'addPose' 'gm'}} class="btn btn-default">Add GM Pose</button>
    <button {{action 'addPose' 'ooc'}} class="btn btn-default">Add OOC Comment</button>
    <button {{action 'addPose' 'pose'}} class="btn btn-primary">Add Pose</button>
{{/if}}`
