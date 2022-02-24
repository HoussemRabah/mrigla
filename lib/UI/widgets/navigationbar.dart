import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mrigla/UI/pages/HomeUI.dart';
import '/../Bloc/navigation/navigation_bloc.dart';
import '/../constants.dart';
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
    return BlocProvider(
      create: (context) => navigationBloc,
      child: Container(
        decoration: BoxDecoration(
            color: colorWhite,
            boxShadow: [shadows],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return SalomonBottomBar(
                unselectedItemColor: colorForceBold,
                selectedItemColor: colorMain,
                onTap: (index) {
                  switch (index) {
                    case 1:
                      context
                          .read<NavigationBloc>()
                          .add(NavigationEventCommande());
                      break;
                    case 2:
                      context
                          .read<NavigationBloc>()
                          .add(NavigationEventStore());
                      break;
                    case 3:
                      context.read<NavigationBloc>().add(NavigationEventCar());
                      break;
                    default:
                      context
                          .read<NavigationBloc>()
                          .add(NavigationEventService());
                      break;
                  }
                  _selectedIndex = index;
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
                ]);
          },
        ),
      ),
    );
  }
}
