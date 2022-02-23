import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrigla/UI/pages/LoginUI.dart';
import '/../Bloc/auth/user_bloc.dart';
import '/../Repository/user_repo.dart';
import '/../Bloc/auth/auth_bloc.dart';
import '/../constants.dart';
import 'loading.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  _AppBarHomeState createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(
              userDB: RepositoryProvider.of(context),
              userAuth: authBloc.user,
            )..add(UserEventInit()),
          )
        ],
        child: Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: borderRadius,
            ),
            width: double.infinity,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserStateLoading)
                  return Loading();
                else
                  return ListTile(
                    leading: Image.asset("assets/logoBlack.png"),
                    title: Text(
                      '${(state as UserStateLoaded).user.nom} ${(state as UserStateLoaded).user.prenom}',
                      style: textStyleSimple,
                    ),
                    subtitle: Text(
                      'cliquez pour voir votre profil',
                      style: textStyleSmall,
                    ),
                    trailing: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: colorForce,
                          borderRadius: borderRadius,
                          boxShadow: [shadows]),
                      child: Text("${(state as UserStateLoaded).points} points",
                          style: textStyleSmall),
                    ),
                  );
              },
            )),
      ),
    );
  }
}
