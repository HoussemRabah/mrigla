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
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: borderRadius,
        ),
        width: double.infinity,
        child: ListTile(
          leading: Image.asset("assets/logoBlack.png"),
          title: Text(
            'user name',
            style: textStyleSimple,
          ),
          subtitle: Text(
            'clicker ici pour voir votre profil',
            style: textStyleSmall,
          ),
          trailing: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                color: colorForce,
                borderRadius: borderRadius,
                boxShadow: [shadows]),
            child: Text("XX points", style: textStyleSmall),
          ),
        ));
  }
}
