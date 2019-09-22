# API openweather client for AresMush

This is a plugin for real weather reporting for game areas.
It's based off [OpenWeatherLite](https://github.com/zsyed91/) Ruby library.

# Requirements
* [An OpenWeather Map API Key](https://openweathermap.org/)

# Configuration
1. Put this plugin in ~/aresmush/plugins/openweather
1. Feel free to disable the stock weather plugin.
1. Use the included openweather.yml and copy it to  ~/aresmush/game/conf/openweather.yml. Edit this file and put in your API key from Openweather Map
1. Edit ~/aresmush/plugins/describe/room_desc_builder.rb and slip in the room
description hook for Openweather plugin. Change the lines from the standard
weather module to Openweather.

In room_desc_builder.rb, change it to look like the below
<pre>
    def self.weather(room)
        return nil if !AresMUSH::Openweather.is_enabled?
        w = Openweather.weather_for_area(room.area_name)
        w ? "%R%R#{w}" : nil
      end
</pre>
# Commands
* openweather - will display a table of your areas and the weather for that area pulled from real time data!
* openweather/reset - Reset weather by forcing an internet update to the API fetching real time data.

# If something Goes wrong??
I've tested this pluging on a test system, but of course I can't imagine all
the cases in the wild. If something blows up be sure to open an github issue with
the error and any log information. Also include the contents of the API results as well. 

To get the results
in game do 
<pre>
ruby Openweather.current_weather
</pre> This should give all the variables the API got for the area and will help in debugging.

# Oddities.
Seasons and time of day (ie, it's day or night) are not provided by Openweather. These come from the ictime plugin in base AresMUSH. So if you have an area like New York and another like London, They will all use the same ictime timezone. I don't
think area ICTimezones exist yet in ares.

# Customizations
Feel free to change the descriptions in the openweather.yml file, and or 
language in the ~/aresmush/plugins/openweather/locales/locale_en.yml

# Author
Dennis De Marco (dennis@demarco.com)/Fenris@SpirtLakeMU
# Reference Links
* [API Data Return format](https://openweathermap.org/current#current_JSON)
* [Weather condition codes](https://openweathermap.org/weather-conditions)
