// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'dart:developer';
// import 'package:transparent_image/transparent_image.dart';
// import 'add_image.dart';
//
// final _firestore = FirebaseFirestore.instance;
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home Page')),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => AddImage()));
//         },
//       ),
//       body: ImageStream()
//     );
//   }
// }

//
// class ImageStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: _firestore.collection('url').doc('url').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//             return Container(
//               padding: EdgeInsets.all(4),
//               child: GridView.builder(
//                   itemCount:
//                   _firestore.collection('url').toString().length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3),
//                   itemBuilder: (context, index) {
//                     return Container(
//                         margin: EdgeInsets.all(3),
//                         child: FadeInImage.memoryNetwork(
//                           fit: BoxFit.cover,
//                           placeholder: kTransparentImage,
//                           image: snapshot.data['url'],
//                           //image: snapshot.data.docs.get('imageURLs')),
//                         ));
//                   }),
//             );
//         });
//   }
// }

