# Timetable

### Timings API

Navigate to https://dawa-tools.herokuapp.com/v1/ with a browser or use `curl`.

```
$ curl https://dawa-tools.herokuapp.com/v1/timings/daily?timestamp=1481929200

{"for":"daily","date":"03-01-2017","hijri":"05-04-1438","hijri_formatted":"Sabt
Rabia II  3 17:39:17 1438","calculation_method":"Muslim World League Fajr 18.0
degrees, Isha 17.0 degrees","juristic_method":"Standard (Hanbali, Maliki,
Shafi)","daylight":"-/-","timezone":"UTC+01:00","latitude":"42.6629","longitude":"21.1655","city":"Pristina","country":"Kosovo","qibla_direction":"137","type":"prayer_times","data":{"fajr":"05:50","shurooq":"07:02","dhuhr":"11:45","asr":"14:06","maghrib":"16:22","isha":"18:00"}}
```

### TODO
- [ ] Add country/city params
- [ ] Webhook URL when a notification is displayed
- [ ] Webhook URL when a notification is clicked
- [ ] Webhook URL when a notification is dismissed


## License

Timings API is Copyright (c) 2016-2018 Puntoria, Inc. It is free software, and may be redistributed under the AGPL license
detailed in the [LICENSE] file.

[LICENSE]: /LICENSE
