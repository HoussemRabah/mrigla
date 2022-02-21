import 'package:flutter/material.dart';
import '/../constants.dart';

// use this textStyles : textStyleTitle,textStyleBig,textStyleSimple,textStyleSouSimple

class LoginSuccess extends StatelessWidget {
  const LoginSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'done',
        style: textStyleTitle,
      ),
    );
  }
}
