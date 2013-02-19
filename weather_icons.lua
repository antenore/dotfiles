function conky_weather_icon(icao)
     local type
     type = conky_parse("${weather http://weather.noaa.gov/pub/data/observations/metar/stations/ " .. icao .. " weather}")
     if (type == "drizzle") or (type == "rain") then
        return "${image ~/pics/weather/rain.png -p 220,140}"
     end
     if (type == "snow") or (type == "snow grains") then
        return "${image ~/pics/weather/snow.png -p 220,140}"
     end
     type = conky_parse("${weather http://weather.noaa.gov/pub/data/observations/metar/stations/ " .. icao .. " cloud_cover}")
     if (type == "clear") or (type == "partly cloudy") or (type == "cloudy") then
        return "${image ~/pics/weather/" .. type .. ".png -p 220,140}"
     end
     return "${image ~/pics/weather/none.png -p 220,140}"
end
/usr/share/icons/Humanity/status/16/stock_weather-cloudy.svg
/usr/share/icons/Humanity/status/16/stock_weather-few-clouds.svg
/usr/share/icons/Humanity/status/16/stock_weather-fog.svg
/usr/share/icons/Humanity/status/16/stock_weather-night-clear.svg
/usr/share/icons/Humanity/status/16/stock_weather-night-few-clouds.svg
/usr/share/icons/Humanity/status/16/stock_weather-showers.svg
/usr/share/icons/Humanity/status/16/stock_weather-snow.svg
/usr/share/icons/Humanity/status/16/stock_weather-storm.svg
/usr/share/icons/Humanity/status/16/stock_weather-sunny.svg
