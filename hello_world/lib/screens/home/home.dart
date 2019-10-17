import 'package:flutter/material.dart';
import 'package:hello_world/screens/home/text_section.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
     // title: Text("Hello"),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:[
        TextSection(Colors.green, 'Register'),
        TextSection(Colors.red, 'Login'),
      ],

    )
    );


  }

}

