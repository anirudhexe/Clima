import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = new WeatherModel();
  int temp;
  int condn;
  String city;
  String weatherIcon;
  String message;
  int time;
  double wind;

  @override
  void initState() {
    super.initState();
    update(widget.locationWeather);
  }

  void update(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temp = 0;
        condn = 0;
        city = 'NULL';
        weatherIcon = '';
        message = 'Cannot display weather';
        time=0;
        wind=0;
        return;
      }
      temp = (weatherdata['main']['temp']).toInt();
      condn = weatherdata['weather'][0]['id'];
      city = weatherdata['name'];
      weatherIcon = weather.getWeatherIcon(condn);
      message = weather.getMessage(temp);
      time = weather.getTime();
      wind=weatherdata['wind']['speed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/${time}.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var data = await weather.getLocationWeather();
                      update(data);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName=await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if(typedName!=Null) {
                        var weatherdata = await weather.getcityweather(typedName);
                        update(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$city',
                      style: kcityTextStyle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '$temp°',
                          style: kTempTextStyle,
                        ),
                        Text(
                          '$weatherIcon',
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                            Icons.wind_power_rounded,
                            size: 60.0,
                        ),
                        Text(
                          ' ~ ${wind.toString()}',
                          style: kTempTextStyle,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                child: Text(
                  "\"$message\"",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
