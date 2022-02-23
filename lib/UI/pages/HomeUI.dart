import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrigla/Bloc/navigation/navigation_bloc.dart';
import 'package:mrigla/UI/pages/ServicesPageUI.dart';
import '/../UI/pages/LoginUI.dart';
import '/../Bloc/auth/auth_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider(create: (context) => NavigationBloc()),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          bottomNavigationBar: NavigationBarHome(),
          body: Column(
            children: [
              AppBarHome(),
              BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  if (state is NavigationStateService) return ServicesPage();
                  return Text("${state.index}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
