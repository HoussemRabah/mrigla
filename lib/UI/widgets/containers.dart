import 'package:flutter/material.dart';
import '../../constants.dart';

class Sqaure extends StatelessWidget {
  final Widget child;
  const Sqaure({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      child: child,
      decoration: BoxDecoration(
        color: colorForce,
        borderRadius: borderRadius,
      ),
    );
  }
}

class SqaureRed extends StatelessWidget {
  final Widget child;
  const SqaureRed({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      child: child,
      decoration: BoxDecoration(
        color: colorRed,
        borderRadius: borderRadius,
      ),
    );
  }
}

class SqaureBlue extends StatelessWidget {
  final Widget child;
  const SqaureBlue({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      child: child,
      decoration: BoxDecoration(
        boxShadow: [shadows],
        color: colorMain,
        borderRadius: borderRadius,
      ),
    );
  }
}
