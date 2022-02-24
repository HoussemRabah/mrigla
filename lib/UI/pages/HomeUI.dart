import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrigla/Bloc/auth/user_bloc.dart';
import 'package:mrigla/Bloc/commande/commande_bloc.dart';
import 'package:mrigla/Bloc/navigation/navigation_bloc.dart';
import 'package:mrigla/Repository/commande_repo.dart';
import 'package:mrigla/Repository/user_repo.dart';
import 'package:mrigla/UI/pages/ServicesPageUI.dart';
import '/../UI/pages/LoginUI.dart';
import '/../Bloc/auth/auth_bloc.dart';
import '/../UI/widgets/navigationbar.dart';
import '/../UI/widgets/appbar.dart';
import '/../constants.dart';
import 'CommandePageUI.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

NavigationBloc navigationBloc = NavigationBloc();
UserBloc userBloc = UserBloc(userAuth: authBloc.user, userDB: UserRepository());
CommandeBloc commandeBloc = CommandeBloc(commandeDB: CommandeRepository());

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: userBloc),
        BlocProvider.value(
          value: commandeBloc,
        ),
        BlocProvider(create: (context) => navigationBloc),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: colorBack,
          bottomNavigationBar: NavigationBarHome(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppBarHome(),
                BlocBuilder<NavigationBloc, NavigationState>(
                  builder: (context, state) {
                    if (state is NavigationStateService) return ServicesPage();

                    if (state is NavigationStateCommande) return CommandePage();
                    return Text("${state.index}");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
