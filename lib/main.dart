import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proxyprovider/screens/welcome.dart';
import 'package:provider/provider.dart';
import 'package:proxyprovider/services/geolocator_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GeoLocatorService geoService = GeoLocatorService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            FutureProvider(create: (context) => geoService.getCoords(),),
            ProxyProvider<Position,Future<List<Placemark>>>( 
              update: (context,position,placemarks) => (position !=null) ? geoService.getAddress(position) :null,
            )
          ],
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(body1: TextStyle(fontSize: 20.0)),
          primarySwatch: Colors.blue,
        ),
        home: Welcome(),
      ),
    );
  }
}

