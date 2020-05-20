import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          create: (BuildContext context)=>WeatherInfo(),
          child: Scaffold(
        appBar: AppBar(
          title:Text('Temperature'),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                temperatureType(),
                temperatureValue(),
              ],
            ),
          ),
        ),
        floatingActionButton: myFloatingActionButton(),
      ),
    );
  }
}

class temperatureType extends StatelessWidget {

  Color decideColor(WeatherInfo info){
    return info.tempType == 'celcius' ? Colors.green : Colors.red;
  }
  
  @override
  Widget build(BuildContext context) {

    var weatherInfo = Provider.of<WeatherInfo>(context);
    return Container(
      child: Text(weatherInfo.tempType,style: TextStyle(fontSize:24,color:decideColor(weatherInfo))),
    );
  }
}

class temperatureValue extends StatelessWidget {

  Color decideColor(WeatherInfo info){
    return info.tempType == 'celcius' ? Colors.green : Colors.red;
  }

  double ferVal(WeatherInfo info){
    double cel = info.tempVal;
    double farn = 1.8*(cel)+32;
    return farn;
  }
  @override
  Widget build(BuildContext context) {
    var weatherInfo = Provider.of<WeatherInfo>(context);
    return Container(
      child: Text(ferVal(weatherInfo).toString(),style: TextStyle(fontSize:24,color:decideColor(weatherInfo)))
    );
  }
}

class myFloatingActionButton extends StatelessWidget {

  Color decideColor(WeatherInfo info){
    return info.tempType == 'celcius' ? Colors.green : Colors.red;
  }
  @override
  Widget build(BuildContext context) {

    var weatherInfo = Provider.of<WeatherInfo>(context);

    return FloatingActionButton(
      backgroundColor: decideColor(weatherInfo),
        onPressed: (){
          String newWeatherType = weatherInfo.tempType == 'celcius' ? 'Fahrenheit' : 'celcius';
          String  newWeatherVal = weatherInfo.tempVal == 25 ? '77' : 25;
          weatherInfo.tempType = newWeatherType;
        },
        child: Icon(Icons.arrow_upward),
        tooltip: 'change temperature',
        );
  }
}

class WeatherInfo with ChangeNotifier{
  
  String _tempType = 'celcius';
  double _tempVal = 25;

  WeatherInfo(String type, double val){
    type = this._tempType;
    val = this._tempVal;
  }
  
  //double get tempVal => _tempVal;
  //String get tempType =>_tempType;

  set temperature(double newTemp){
    _tempVal = newTemp;
    notifyListeners();
  }

  set tempType(String newtempVal){
    _tempType = newtempVal;
    notifyListeners();
  }
}
