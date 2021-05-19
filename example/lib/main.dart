import 'package:crecexdiez_advertising/crecexdiez_advertising.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CreceXDiez Advertising example app'),
        ),
        body: Center(
          child: Crecex10Advertising(
            id: 12,
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }
}
