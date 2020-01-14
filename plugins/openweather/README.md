# API openweather client for AresMush

## Author
Dennis De Marco (dennis@demarco.com)/Fenris@SpirtLakeMU

## Overview

This is a plugin for real weather reporting for game areas.
It's based off [OpenWeatherLite](https://github.com/zsyed91/) Ruby library.

## Requirements
* [An OpenWeather Map API Key](https://openweathermap.org/)

## Installation

In the game, run `plugin/install openweather`.

You'll probably also want to disable the main weather plugin. Go to Admin -> Setup -> Enable or Disable Plugins and uncheck 'weather'.

Edit your ~/aresmush/game/config/secrets.yml and add the API_KEY

    openweather_api_key: YOUR_API_KEY


## Commands
* openweather - will display a table of your areas and the weather for that area pulled from real time data!
* openweather/reset - Reset weather by forcing an internet update to the API fetching real time data.

## If something goes wrong??

I've tested this pluging on a test system, but of course I can't imagine all
the cases in the wild. If something blows up be sure to open an github issue with
the error and any log information. Also include the contents of the API results as well. 

To get the results, you can use this command to get the raw contents of the API results.

    ruby Openweather.current_weather

This should give all the variables the API got for the area and will help in debugging.

## Oddities and weirdness

* Seasons and time of day (ie, it's day or night) are not provided by Openweather. These come from the ICTime plugin in base AresMUSH. The base ICTime module does not have timezones, but there are code hooks where you can differentiate ICTime by area if you add custom code.
* Openweather makes the API call in the background, so inital startup may take
a second or two to populate the data. 

## Customizations

Feel free to change the descriptions in the openweather.yml file, and or 
language in the ~/aresmush/plugins/openweather/locales/locale_en.yml

## Common Gotchas
* Make sure when adding the API key that it is on one line (no dashes) and falls
under the secrets subkey. 

    secrets:
        openweather_api_key: your_api_key


* If you need to make a change or fix in the config files do an **openweather/reset**. That will force a weather update using the new configs. If that does not work, do **load openweather** to reload the plugin.
* Some users report that OpenWeather API_KEY takes a couple of hours to register/activate from openweather.org There
may be an e-mail that you need to click to complete the setup. So check your spam folder.
* Use a single quote for zip codes in openweather.yml.  ie, 

    Brookline:
      zip: '03033'

## Reference Links

* [API Data Return format](https://openweathermap.org/current#current_JSON)
* [Weather condition codes](https://openweathermap.org/weather-conditions)

## Uninstalling

Removing the plugin requires some code fiddling.  See [Uninstalling Plugins](https://www.aresmush.com/tutorials/code/extras.html#uninstalling-plugins).