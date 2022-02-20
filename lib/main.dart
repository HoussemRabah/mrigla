import 'package:flutter/material.dart';
import 'package:mrigla/constants.dart';
import '../UI/pages/LoginUI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mrigla',
      theme: ThemeData(
        primaryColor: colorMain,
      ),
      home: LoginPage(),
    );
  }
}
