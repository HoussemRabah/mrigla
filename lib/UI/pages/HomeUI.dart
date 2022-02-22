import 'package:flutter/material.dart';
import '/../UI/widgets/navigationbar.dart';
import '/../UI/widgets/appbar.dart';
import '/../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBack,
        bottomNavigationBar: NavigationBarHome(),
        body: Column(
          children: [
            AppBarHome(),
          ],
        ),
      ),
    );
  }
}
