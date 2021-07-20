import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';




const apikey='1d0e3243f61e0e3cf260990833edc37a';
const openweathermapurl='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
Future<dynamic> getcityweather(String cityname)
 async{

NetworkHelper networkHelper=NetworkHelper('$openweathermapurl?q=$cityname&appid=$apikey&units=metric');
var weatherdata= await  networkHelper.getdata();
return weatherdata;
 }


 Future<dynamic> getlocationweather()
  async{
    Location location=Location();
    await location.getcurrentlocation();
    NetworkHelper networkHelper=NetworkHelper('$openweathermapurl?lat=${(location.latitude)}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherdata=await networkHelper.getdata();
    return weatherdata;
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
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
