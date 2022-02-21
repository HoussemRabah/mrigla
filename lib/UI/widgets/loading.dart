import 'package:flutter/material.dart';
import 'package:mrigla/constants.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: colorMain,
          ),
          Text(
            'Les belles choses prennent du temps',
            style: textStyleBig,
          )
        ],
      ),
    );
  }
}
