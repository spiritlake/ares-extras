# Multiple Connect Screens

**Based on a submission by @TheStranjer.**

Designed for AresMUSH 1.0

## Overview

This change will allow the game to have different connect screens, chosen at random when someone connects.

In `aresmush/plugins/login/events/connection_est_event_handler.rb`, replace the code that determines the connect screen filename with a random selection of all files named `connect*.txt`.

Old code:

        filename = File.join(AresMUSH.game_path, 'text', 'connect.txt')        

New code:

        connect_path = File.join(AresMUSH.game_path, 'text')
        screens = Dir["#{connect_path}/connect*.txt"]
        filename = screens.sample || File.join(connect_path, 'connect.txt')

## Configuration

Connect files must live in `aresmush/game/text` and be named `connect*.txt`.  For example:  `connect.txt, connect1.txt, connect_alt.txt`, etc.

Note that you will only be able to change 'connect.txt' through the web portal.  Any additional connect screens will have to be edited manually.