import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class Welcome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final addressProxy = Provider.of<Future<List<Placemark>>>(context);
    final position = Provider.of<Position>(context);
    return FutureProvider(
      create: (context) => addressProxy,
      child: Scaffold(
        body: (addressProxy != null)
        ? Consumer<List<Placemark>>( 
          builder: (context,addressList,widget){
            return (addressList != null)
            ? _buildList(position, addressList[0])
            : Center(child: CircularProgressIndicator());
          },
        ) 
        : Center(child: CircularProgressIndicator())

      ));
  }
}

Widget _buildList(Position position, Placemark placemark){
  return ListView(children: <Widget>[
    ListTile(title: Text('Your Position',style: TextStyle(fontSize: 25.0))),
    ListTile(leading: Text('Latitude'),trailing: Text(position.latitude.toString()),),
    ListTile(leading: Text('Longitude'),trailing: Text(position.longitude.toString()),),
    ListTile(leading: Text('Speed m/s'),trailing: Text(position.speed.toString()),),
    ListTile(leading: Text('City'),trailing: Text(placemark.locality),),
    ListTile(leading: Text('Country'),trailing: Text(placemark.country),),
    ListTile(leading: Text('Flag'),trailing: Image.network("https://www.countryflags.io/${placemark.isoCountryCode}/flat/32.png"),),
  ],);
}