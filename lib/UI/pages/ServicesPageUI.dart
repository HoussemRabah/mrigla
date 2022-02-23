import 'package:flutter/material.dart';
import 'package:mrigla/constants.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          height: 300,
          width: double.infinity,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
              color: colorMain,
              borderRadius: borderRadius,
              boxShadow: [shadows]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'title kbiiiiir',
                style: textStyleBig.copyWith(color: colorWhite),
              ),
              Text(
                'ktiba sghira',
                style: textStyleSimple.copyWith(color: colorWhite),
              ),
              Image.asset('assets/welcomeLogo.png'),
            ],
          ),
        )
      ],
    );
  }
}
