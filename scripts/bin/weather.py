#!/usr/bin/python
# -*- coding:utf-8 -*-
import urllib2
from BeautifulSoup import BeautifulSoup
WURL = 'http://www.weather.com/weather/right-now/Lausanne+SZXX0017:1:SZ'
soup = BeautifulSoup(urllib2.urlopen(WURL).read())
title = soup.title.string
right_now = (int(soup('span', {
    'class': 'wx-value',
    'itemprop': 'temperature-fahrenheit'
    })[0].string) - 32) * 5/9
feels_like = (int(soup('span', {
    'class': 'wx-value',
    'itemprop': 'feels-like-temperature-fahrenheit'
    })[0].string) - 32) * 5/9
humidity = soup('span', {'class': 'wx-temp', 'itemprop': 'humidity'})[0].string
wind = soup('span', {'class': 'wx-temp'})[0].string
sky = soup('span', {
    'class': 'wx-value',
    'itemprop': 'weather-phrase'
    })[0].string
temp_dict = {
    '  Title :': title,
    '  Feels Like :': str(feels_like) + u'°C' + "  ",
    '  Wind  :': wind + "  ",
    '  Temperature:': str(right_now) + u'°C' + "  ",
    '  Humidity   :': humidity + "  ",
    '  Sky  :': str(sky) + "  ",
}

for key, value in temp_dict.items():
    print key, value
#vim:set fileencoding=UTF-8 :
