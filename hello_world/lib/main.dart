import 'package:flutter/material.dart';
import 'services/authentication.dart';
import 'pages/root_page.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';

/*
final FirebaseApp app = FirebaseApp(
      options: FirebaseOptions(
    googleAppID:'1:505453378364:android:2b82b1678ac7c1b98e7c39',
    apiKey: 'AIzaSyBgk25c7ParYn3k15xfjdeAf9X90WYrA80',
    databaseURL: 'https://esof-1.firebaseio.com',
      )
);*/

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'High On Caffeine',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new Auth()));
  }
}
