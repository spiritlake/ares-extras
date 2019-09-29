# API openweather client for AresMush

This is a plugin for real weather reporting for game areas.
It's based off [OpenWeatherLite](https://github.com/zsyed91/) Ruby library.

# Requirements
* [An OpenWeather Map API Key](https://openweathermap.org/)

# Configuration
* Use plugin/install openweather to install the plugin
* Edit your ~/aresmush/game/config/secrets.yml and add the API_KEY
<pre>
openweather_api_key: YOUR_API_KEY
</pre>

* Edit ~/aresmush/plugins/describe/room_desc_builder.rb and slip in the room
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

# If something goes wrong??
I've tested this pluging on a test system, but of course I can't imagine all
the cases in the wild. If something blows up be sure to open an github issue with
the error and any log information. Also include the contents of the API results as well. 

To get the results
in game do 
<pre>
ruby Openweather.current_weather
</pre> This should give all the variables the API got for the area and will help in debugging.

# Oddities and wierdness
* Seasons and time of day (ie, it's day or night) are not provided by Openweather. These come from the ICTime plugin in base AresMUSH. The base ICTime module does not have timezones, but there are code hooks where you can differentiate ICTime by area if you add custom code.
* Openweather makes the API call in the background, so inital startup may take
a second or two to populate the data. 

# Customizations
Feel free to change the descriptions in the openweather.yml file, and or 
language in the ~/aresmush/plugins/openweather/locales/locale_en.yml

# Common Gotchas
* Make sure when adding the API key that it is on one line (no dashes) and falls
under the secrets subkey. 

<pre>
secrets:
    openweather_api_key: your_api_key
</pre>

* If you need to make a change or fix in the config files do an **openweather/reset**. That will force a weather update using the new configs. If that does not work, do **load openweather** to reload the plugin.

* Some users report that OpenWeather API_KEY takes a couple of hours to register/activate from openweather.org There
may be an e-mail that you need to click to complete the setup. So check your spam folder.


# Author
Dennis De Marco (dennis@demarco.com)/Fenris@SpirtLakeMU
# Reference Links
* [API Data Return format](https://openweathermap.org/current#current_JSON)
* [Weather condition codes](https://openweathermap.org/weather-conditions)
