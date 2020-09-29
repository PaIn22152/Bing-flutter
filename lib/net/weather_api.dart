import 'package:flutter/services.dart';

import 'net_manager.dart';

class WeatherApi {
  Future<dynamic> loadWeatherData(String longitude, String latitude) async {
    // WeatherModelEntity data = await WeatherApi.loadWeatherData("121.6544","25.1552");
    var res =
        await NetManager.getInstance().baseUrl(weatherBaseUrl).get("$longitude,$latitude/weather.json");
    if (res != null && res.status) {
      return res.data;
    }
    return null;
  }
  // https://api.caiyunapp.com/v2.5/sas9gfwyRX2NVehl/121.6544,25.1552/minutely.json
  Future<dynamic> loadMinuteData(String longitude, String latitude) async {
    // WeatherModelEntity data = await WeatherApi.loadWeatherData("121.6544","25.1552");
    var res =
    await NetManager.getInstance().baseUrl(weatherBaseUrl).get("$longitude,$latitude/minutely.json");
    if (res != null && res.status) {
      return res.data;
    }
    return null;
  }

  Future<dynamic> reGeo(String location) async {
    // WeatherModelEntity data = await WeatherApi.loadWeatherData("121.6544","25.1552");
    var res = await NetManager.getInstance().baseUrl(geoBaseUrl).get("$location");
    if (res != null && res.status) {
      return res.data;
    }
    return null;
  }

  Future<dynamic> getOTA() async {
    var res = await NetManager.getInstance().baseUrl(otaBaseUrl).get("");
    if (res != null && res.status) {
      return res.data;
    }
    return null;
  }
}
