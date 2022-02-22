import 'package:flutter/material.dart';
import '/../constants.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  _AppBarHomeState createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: borderRadius,
        ),
        width: double.infinity,
        child: ListTile(
          leading: Image.asset("assets/logo.png"),
          title: Text(
            'user name',
            style: textStyleSimple,
          ),
          subtitle: Text(
            'clicker ici pour voir votre profil',
            style: textStyleSmall,
          ),
          trailing: Container(
            decoration: BoxDecoration(
                color: colorForce,
                borderRadius: borderRadius,
                boxShadow: [shadows]),
            width: 20,
            child: Text("XX points", style: textStyleSmall),
          ),
        ));
  }
}
