import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrigla/Bloc/commande/commande_bloc.dart';
import 'package:mrigla/UI/pages/HomeUI.dart';
import 'package:mrigla/UI/widgets/loading.dart';

class CommandePageView extends StatefulWidget {
  final String commandeBon;
  final int index;
  const CommandePageView(
      {Key? key, required this.commandeBon, required this.index})
      : super(key: key);

  @override
  State<CommandePageView> createState() => _CommandePageViewState();
}

class _CommandePageViewState extends State<CommandePageView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: userBloc),
        BlocProvider.value(value: commandeBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<CommandeBloc, CommandeState>(
            builder: (context, state) {
              if (state is CommandeStateLoading) return Loading();
              if (state is CommandeStateLoaded) {
                if (state.commandes![widget.index].bon != widget.commandeBon) {
                  Navigator.of(context).pop();
                }

                return Column(
                  children: [
                    Text(state.commandes![widget.index].bon),
                  ],
                );
              }
              return Loading();
            },
          ),
        ),
      ),
    );
  }
}
