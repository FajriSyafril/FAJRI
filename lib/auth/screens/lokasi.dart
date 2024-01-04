import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Position? currentLocation;
  List<Placemark> currentPlacemarks = [];

  Future<List<Placemark>> _getPlacemarks(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      return placemarks;
    } catch (e) {
      print("Error getting placemarks: $e");
      return [];
    }
  }

  Future<void> _getLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await _getPlacemarks(position);

      setState(() {
        currentLocation = position;
        currentPlacemarks = placemarks;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget>[
            if (currentLocation != null)
              Column(
                children: [
                  Text(
                    'Current Location:',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Latitude: ${currentLocation!.latitude} Longitude: ${currentLocation!.longitude}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  if (currentPlacemarks.isNotEmpty)
                    Text(
                      ' ${currentPlacemarks[0].subLocality ?? "Not available"}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
        shape: CircleBorder(side: BorderSide(color: Colors.red)),
        splashColor: Colors.black45,
        backgroundColor: Colors.white,
        elevation: 30,
        child: Icon(
          Icons.my_location,
          color: Colors.blue,
        ),
        focusColor: Colors.amber,
      ),
    );
  }
}
