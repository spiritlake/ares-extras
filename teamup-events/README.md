# Teamup Events Integration

> **Deprecated**.  Provided for reference.  May require tweaking to get it to work with the current Ares code.

**Compatibility:** Designed for AresMUSH 0.4

[Teamup.com](https://www.teamup.com/) offers a free, shared, public web calendar for groups.  

I ended up not using it for Ares because the web portal offered all the functionality - and more - with a simpler integration.    I've left the code here as a reference for how you can potentially integrate Ares with an external system like a calendar.

## Installation

1. Remove the existing `events` plugin folder.
2. Copy the `teamup-events` folder to your game's `plugins` folder and rename it to `events`.
3. Move the `events.yml` file to the `game/config` folder.

## Configuration

You'll need to enable the API in Teamup to get an API key, then add two entries to your secrets.yml configuration file based on your Teamup config:

    secrets:
        events:
            calenadar: Your public calendar URL.
            api_key: Your API key
