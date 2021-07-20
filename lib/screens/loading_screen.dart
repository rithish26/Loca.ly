import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
import 'location_screen.dart';





class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData() ;

  }
  void getLocationData() async{


  var weatherdata=await WeatherModel().getlocationweather();

 Navigator.push(context, MaterialPageRoute(builder:(context)
    {
      return LocationScreen(locationWeather: weatherdata);
    }));
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Center(
        child:SpinKitChasingDots(
          color: Colors.white,
          size:50.0,
        ),
      ),
    );

    getLocationData();
  }
}
