import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/../Bloc/auth/user_bloc.dart';
import '/../Bloc/commande/commande_bloc.dart';
import '/../UI/pages/HomeUI.dart';
import '/../UI/widgets/loading.dart';

class CommandePage extends StatefulWidget {
  const CommandePage({Key? key}) : super(key: key);

  @override
  State<CommandePage> createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: userBloc),
        BlocProvider.value(value: commandeBloc),
      ],
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserStateLoading)
            return Loading();
          else
            context
                .read<CommandeBloc>()
                .add(CommandeEventInit((state as UserStateLoaded).user));
          return BlocBuilder<CommandeBloc, CommandeState>(
            builder: (context, state) {
              if (state is CommandeStateLoading)
                return Loading();
              else
                return Text('f');
            },
          );
        },
      ),
    );
  }
}
