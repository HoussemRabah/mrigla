import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrigla/UI/pages/LoginUI.dart';
import '/../Bloc/bloc/auth_bloc.dart';
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
    return BlocProvider.value(
      value: authBloc,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          bottomNavigationBar: NavigationBarHome(),
          body: Column(
            children: [
              AppBarHome(),
            ],
          ),
        ),
      ),
    );
  }
}
