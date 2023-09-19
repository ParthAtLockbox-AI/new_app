import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ipapi/model/weather_res_model.dart';
import 'package:ipapi/service/api_service/api_const.dart';
import 'package:ipapi/service/api_service/api_response.dart';
import 'package:ipapi/service/api_service/base_services.dart';

class WeatherViewModel extends GetxController {
  /// GET USER NAME  API

  static Future<WeatherResponseModel> getWeatherRepo(
      {String? latitude, String? longitude, String? apiKey}) async {
    var response = await APIService().getResponse(
        url:
            '${BaseUrl.baseUrl}?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey',
        apiType: APIType.aGet);
    WeatherResponseModel weatherResponseModel =
        WeatherResponseModel.fromJson(response);
    return weatherResponseModel;
  }

  WeatherResponseModel? weatherData;

  ApiResponse _weatherApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get weatherApiResponse => _weatherApiResponse;

  Future<void> getWeatherViewModel({
    BuildContext? context,
    bool isLoading = true,
  }) async {
    if (isLoading) {
      _weatherApiResponse = ApiResponse.loading(message: 'Loading');
    }
    Position? position;
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        position = await GeolocatorPlatform.instance.getCurrentPosition(
            locationSettings:
                LocationSettings(accuracy: LocationAccuracy.high));
        print('--------${position.latitude}');
        print('--------${position.longitude}');
      }
    } catch (e) {}
    try {
      if (position != null) {
        weatherData = await getWeatherRepo(
          apiKey: '439d4b804bc8187953eb36d2a8c26a02',
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString(),
        );
      } else {
        GetSnackBar(title: 'Give location permission first');
      }

      print("weatherData=response==>$weatherData");

      _weatherApiResponse = ApiResponse.complete(weatherData);
    } catch (e) {
      print("weatherData=e==>${e}");

      _weatherApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
