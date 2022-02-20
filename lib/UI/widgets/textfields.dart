import 'package:flutter/material.dart';

import '../../constants.dart';

class TextFieldSimple extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? error;
  const TextFieldSimple(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: colorWhite, borderRadius: borderRadius),
      child: TextField(
        controller: controller,
        style: textStyleSimple,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "$hint",
            errorText: error,
            hintStyle: textStyleSimple),
      ),
    );
  }
}

class TextFieldPhone extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? error;
  const TextFieldPhone(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: colorWhite, borderRadius: borderRadius),
      child: TextField(
        controller: controller,
        style: textStyleSimple,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "$hint",
            errorText: error,
            hintStyle: textStyleSimple),
      ),
    );
  }
}

class TextFieldPassword extends StatelessWidget {
  final TextEditingController controller;
  final String? error;
  const TextFieldPassword(
      {Key? key, required this.controller, required this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: colorWhite, borderRadius: borderRadius),
      child: TextField(
        style: textStyleSimple,
        obscureText: true,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.remove_red_eye),
            border: InputBorder.none,
            hintText: "mot de passe...",
            errorText: error,
            hintStyle: textStyleSimple),
      ),
    );
  }
}
