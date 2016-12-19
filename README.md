DawaTools API

Run
---

```
$ bundle install
$ rackup

[2016-12-17 14:24:02] INFO  WEBrick 1.3.1
[2016-12-17 14:24:02] INFO  ruby 2.3.1 (2016-04-26) [x86_64-darwin15]
[2016-12-17 14:24:02] INFO  WEBrick::HTTPServer#start: pid=87374 port=9292

```

### Timings

Navigate to http://localhost:9292/v1/ with a browser or use `curl`.

```
$ curl http://localhost:9292/v1/timings/daily?timestamp=1481929200

{"data":{"type":"prayer_times","for":"daily","hijri":"17-03-1438","sunrise":"05:15","fajr":"05:45","shurooq":"06:56","dhuhr":"11:37","asr":"13:57","maghrib":"16:12","isha":"17:51"},"prayer_method_name":"0","daylight":"-/-","timezone":"UTC+01:00","latitude":"42.6629","longitude":"21.1655","city":"Pristina","country":"Kosovo","qibla_direction":"137"}

```
