import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey='56c68c7f2974521e815e5c0734febe6b';

class WeatherModel {
  double lat;
  double lon;

  Future <dynamic> getcityweather(String cityname)
  async{
    var url='https://api.openweathermap.org/data/2.5/weather?q=${cityname}&appid=$apikey&units=metric';
    Network network=new Network(url);
    var data=await network.getdata();
    return data;
  }

  Future<dynamic>getLocationWeather() async{
    Location location=new Location();
    await location.getcurrentlocation();
    lat=location.latitude;
    lon=location.longitude;

    Network network=new Network('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apikey&units=metric');

    var data = await network.getdata();

    return data;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 30) {
      return 'Feels hot doesn\'t it 🫠';
    } else if (temp > 20) {
      return 'Ideal temperature for you 😉';
    } else if (temp > 10) {
      return 'Wear a hoodie maybe';
    } else{
      return 'It\'s freezing cold outside 🥶';
    }
  }

  int getTime()
  {
    var dt=DateTime.now();
    if(dt.hour>=6 && dt.hour<=16)
      return 0;
    else
      return 1;
  }
}
