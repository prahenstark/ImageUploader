import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_uploader/gallery.dart';
import 'package:image_uploader/gallery.dart';
import 'package:image_uploader/launchPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      initialRoute: LaunchPage.id,
      routes: {
        //'/': (context) => SplashScreen(),
        LaunchPage.id: (context) => LaunchPage(),
        GalleryPage.id: (context) => GalleryPage(),

      },
    debugShowCheckedModeBanner: false,
  ),
  );
}


