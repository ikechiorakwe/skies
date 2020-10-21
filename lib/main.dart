import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';


void main()=> runApp(
  MaterialApp(
    title: "Skies",
    home: Home()
  )
);

class Home extends StatefulWidget {
  @override

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  // Position _currentPosition;
  // String _currentAddress;

Future getWeather () async {
  http.Response response = await http.get("api.openweathermap.org/data/2.5/weather?q=Lagos&appid=16d81bd4dc328bcaedb14abbcbd6291d");
  var results = jsonDecode(response.body);
  setState(() {
   this.temp = results['main']['temp'];
   this.description = results['weather'][0]['description'];
   this.currently = results['weather'][0]['main']; 
   this.humidity = results['main']['humidity'];
   this.windSpeed = results['wind']['speed'];
  });
}

// _getCurrentLocation() {
//     geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });

//       _getAddressFromLatLng();
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   _getAddressFromLatLng() async {
//     try {
//       List<Placemark> p = await geolocator.placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);

//       Placemark place = p[0];

//       setState(() {
//         _currentAddress =
//             "${place.locality}, ${place.postalCode}, ${place.country}";
//       });
//     } catch (e) {
//       print(e);
//     }
//   }


  @override
  void initState () {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          "Skies",
          style: TextStyle(color: Colors.white),
          ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage("assets/images/sky.jpeg"),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> 
                [
                  SizedBox(
                    height: 12.0,
                  ),
                  Expanded(
                    child: Text(
                      "Lekki",
                      style: TextStyle(color: Colors.black, fontSize:20.0, fontWeight:FontWeight.w600),
                      ),
                  ),
                  Expanded(
                    child: Text(
                     temp != null? temp.toString() + "\u00B0": "loading",
                      style: TextStyle(color: Colors.black, fontSize:20.0, fontWeight:FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      currently != null? currently.toString(): "loading",
                      style: TextStyle(color: Colors.black, fontSize:20.0, fontWeight:FontWeight.w600),
                    ),
                  ),
                ],
                ),
            ),
             Expanded(
               flex: 3,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                      children: <Widget>
                      [
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                          title: Text("Temperature"),
                          trailing: Text(
                            currently != null? currently.toString(): "loading",
                            ),
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.cloud),
                          title: Text("Weather"),
                          trailing: Text(
                            description != null? description.toString(): "loading",
                            ),
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.sun),
                          title: Text("Humidity"),
                          trailing: Text(
                            humidity != null? humidity.toString(): "loading",
                            ),
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.wind),
                          title: Text("Wind Speed"),
                          trailing: Text(
                            windSpeed != null? windSpeed.toString(): "loading",
                            ),
                        ),
                      ],
                    ),
                ),                
                ),            
          ],
          ),
      ),
    );
  }
}