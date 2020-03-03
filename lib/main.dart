
import 'package:flogger/flogger.dart';
import 'package:flutter/material.dart';
import 'package:stock_easy/ui/splash_page.dart';

void main() {
  Flogger.init(FloggerConfig(true));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Easy',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrangeAccent,
      ),
      home: SplashPage(),
    );
  }
}
