import 'package:calc_training/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'シンプルすぎる計算脳トレ',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

