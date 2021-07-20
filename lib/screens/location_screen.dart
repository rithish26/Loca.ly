import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
import '../services/weather.dart';
import 'city_screen.dart';
class LocationScreen extends StatefulWidget {
   LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather=WeatherModel();
  String cityname;
String weathericon;
  int temp;
  String weathermsg;
  int imgno;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.locationWeather);
    bkgimg(temp);
  }

  void updateUi(dynamic weatherdata)
  {
 setState(() {

   if(weatherdata==null)
     {
       temp=0;
       weathericon='ERROR';
       weathermsg='NO WEATHER DATA';
       cityname='';
       return;
     }
   double temperatur=weatherdata['main']['temp'];
   temp=temperatur.toInt();
   var condition=weatherdata['weather'][0]['id'];
   cityname=weatherdata['name'];
   weathericon=weather.getWeatherIcon(condition);
   weathermsg=weather.getMessage(temp);
 });


  }
  void bkgimg(int temp)
  {
    if(temp>=30)
    {
    imgno=2;
    }
    else if(temp>=20)
      {
        imgno=1;
      }

    else if(temp<20)
      {
        imgno=3;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/image$imgno.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherdata= await weather.getlocationweather();
                      updateUi(weatherdata);
                      bkgimg(temp);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedname=await Navigator.push(context,MaterialPageRoute(builder: (context)
                      {
                          return CityScreen();
                      }));
                      if(typedname!=null)
                        {
                            var weatherdata=await weather.getcityweather(typedname);
                            updateUi(weatherdata);
                            bkgimg(temp);
                        }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: 30.0),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                  Text(
                  weathericon,
                  style: kConditionTextStyle,
                ),
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),

                  ],
                ),
              ),
              SizedBox(height: 300),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Center(
                  child: Text(
                    '$weathermsg in $cityname!',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

