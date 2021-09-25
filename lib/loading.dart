// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_uploader/launchPage.dart';
//
// class LoadingScreen extends StatefulWidget {
//
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }
//
// class _LoadingScreenState extends State<LoadingScreen> {
//
//   double lat;
//   double long;
//
//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//     print("Hello inside init");
//   }
//
//   _getLocation() async
//   {
//     Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//     debugPrint('location: ${position.latitude}');
//     final coordinates = new Coordinates(position.latitude, position.longitude);
//     var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     lat = coordinates.latitude;
//     long = coordinates.longitude;
//     var first = addresses.first;
//     print("${first.featureName} : ${first.addressLine}");
//     print(lat);
//     print(long);
//
//
//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return LaunchPage(locationData: addresses, cordinateData: coordinates,);
//     }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SpinKitDoubleBounce(
//           color: Colors.white,
//           size: 100.0,
//         ),
//       ),
//     );
//   }
// }