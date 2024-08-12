import 'package:flash_light/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flash",
      // checkerboardOffscreenLayers: true,
      debugShowCheckedModeBanner: false,
      // darkTheme: ThemeData.dark(),

      home: Home(),
    );
  }
}
