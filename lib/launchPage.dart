import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_uploader/gallery.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';


final _firestore = FirebaseFirestore.instance;


class LaunchPage extends StatefulWidget {
  static const String id = 'launch_screen';

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {

  final picker = ImagePicker();
  double latitude;
  double longitude;
  String address;

  @override
  void initState() {
    super.initState();
    getLocation();
    print("Hello inside init");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text('Your location is $address')),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      color: Colors.lightBlue,
                      onPressed: getImageCamera,
                      child: Icon(Icons.add_a_photo),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    FlatButton(
                      color: Colors.lightBlue,
                      onPressed: getImageGallery,
                      child: Icon(CupertinoIcons.add),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      //body: pageCaller(_selectedIndex),
    );
  }

  Widget _appBar(BuildContext context) {
    return new AppBar(
      title: Text('Image Geotagging'),
      actions: <Widget>[
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 13),
            child: Icon(CupertinoIcons.photo),
          ),
          onTap: () {
            Navigator.pushNamed(context, GalleryPage.id);
          },
        ),
      ],
      elevation: 0,
    );
  }

  Future getImageGallery() async {
    final image = await picker.getImage(source: ImageSource.gallery);

    // Get image from gallery.
    //var image = await  picker.getImage(source: ImageSource.gallery);
    _uploadImageToFirebase(image);
  }

  Future getImageCamera() async {
    final image = await picker.getImage(source: ImageSource.camera);

    // Get image from gallery.
    //var image = await  picker.getImage(source: ImageSource.gallery);
    _uploadImageToFirebase(image);
  }

  Future<void> _uploadImageToFirebase(PickedFile image) async {
    final File imageFile = File(image.path);
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'images/image${randomNumber}.jpg';

      // Upload image to firebase.
      final Reference storageReference = FirebaseStorage.instance.ref().child(imageLocation);
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() => _addPathToDatabase(imageLocation));
      //_addPathToDatabase(imageLocation);
    }catch(e){
      print(e.message);
    }
  }

  Future<void> _addPathToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage.instance.ref().child(text);
      var imageString = await ref.getDownloadURL();

      // Add location and url to database
      await _firestore.collection('storage').add({
        'url': imageString ,
        'store': text,
        'location': address,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),

      });
    }catch(e){
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          }
      );
    }
  }


  Future<void> getLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    print(coordinates.longitude);
    print(coordinates.latitude);

    latitude = coordinates.latitude;
    longitude = coordinates.longitude;
    address = addresses.first.addressLine.toString();

    setState(() {});
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return LaunchPage(locationData: addresses, cordinateData: coordinates,);
    // }));
  }
}



// class Record {
//   final String location;
//   final String url;
//   final DocumentReference reference;
//
//   Record.fromMap(Map<String, dynamic> map, {this.reference})
//       : assert(map['location'] != null),
//         assert(map['url'] != null),
//         location = map['location'],
//         url = map['url'];
//
//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data(), reference: snapshot.reference);
//
//   @override
//   String toString() => "Record<$location:$url>";
// }