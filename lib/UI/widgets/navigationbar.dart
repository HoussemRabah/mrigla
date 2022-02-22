import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mrigla/constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationBarHome extends StatefulWidget {
  const NavigationBarHome({Key? key}) : super(key: key);

  @override
  _NavigationBarHomeState createState() => _NavigationBarHomeState();
}

int _selectedIndex = 0;

class _NavigationBarHomeState extends State<NavigationBarHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: SalomonBottomBar(
          unselectedItemColor: colorForceBold,
          selectedItemColor: colorMain,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          items: [
            SalomonBottomBarItem(
                icon: Icon(Ionicons.rocket), title: Text('services')),
            SalomonBottomBarItem(
                icon: Icon(Ionicons.pricetags), title: Text('commandes')),
            SalomonBottomBarItem(
                icon: Icon(Ionicons.storefront), title: Text('marcheé')),
            SalomonBottomBarItem(
                icon: Icon(Ionicons.car), title: Text('ma voiture')),
          ]),
    );
  }
}
