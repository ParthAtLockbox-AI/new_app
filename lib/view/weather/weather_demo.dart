import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipapi/model/weather_res_model.dart';
import 'package:ipapi/service/api_service/api_response.dart';
import 'package:ipapi/view_model/get_weather_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherViewModel weatherViewModel = Get.put(WeatherViewModel());
  @override
  initState() {
    weatherViewModel.getWeatherViewModel(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WeatherViewModel>(
        builder: (controller) {
          if (controller.weatherApiResponse.status == Status.LOADING) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.weatherApiResponse.status == Status.COMPLETE) {
            WeatherResponseModel weatherResponseModel =
                controller.weatherApiResponse.data;
            var currentWeather = weatherResponseModel.current;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${weatherResponseModel?.timezone}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Feel Like ${currentWeather?.feelsLike} C. ${currentWeather?.weather?.first.description}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Wind Speed : ${currentWeather?.windSpeed} m/s',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Humidity : ${currentWeather?.humidity}%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'UV : ${currentWeather?.uvi}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Dew Point : ${currentWeather?.dewPoint} C',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Visibility : ${currentWeather?.dewPoint} km',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Try Again'),
            );
          }
        },
      ),
    );
  }
}
