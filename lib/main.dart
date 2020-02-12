import 'package:flutter/material.dart';
import 'package:stock_easy/ui/home_page.dart';

void main() => runApp(MyApp());

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
      home: HomePage(),
    );
  }
}
