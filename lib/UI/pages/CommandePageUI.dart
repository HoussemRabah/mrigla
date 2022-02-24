import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
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
              else if (state is CommandeStateLoaded)
                return Column(
                  children: [
                    CommandesHeader(state: state),
                  ],
                );
              else
                return Text('f');
            },
          );
        },
      ),
    );
  }
}

class CommandesHeader extends StatelessWidget {
  final CommandeState state;

  const CommandesHeader({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [shadows],
        color: colorMain,
        borderRadius: borderRadius,
      ),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(8.0),
            decoration:
                BoxDecoration(color: colorForce, borderRadius: borderRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/iconMN.png',
                  fit: BoxFit.fitWidth,
                  width: 68,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Paiement total à la livraison',
                  style: textStyleSmall,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${(state as CommandeStateLoaded).calcTotalPriceOfCommandes()} DA',
                  style: textStyleTitle.copyWith(color: colorMain),
                  textAlign: TextAlign.center,
                ),
                if ((state as CommandeStateLoaded).commandeServices != null)
                  Text(
                    '+ Paiement des frais de services',
                    style: textStyleSmall.copyWith(color: colorMain),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          )),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
              child: Column(
            children: [
              if ((state as CommandeStateLoaded).commandes != null)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: colorForce, borderRadius: borderRadius),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/iconMN.png',
                        fit: BoxFit.fitWidth,
                        width: 48,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        '${(state as CommandeStateLoaded).commandes!.length} pieces',
                        style: textStyleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 8.0,
              ),
              if ((state as CommandeStateLoaded).commandeServices != null)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: colorForce, borderRadius: borderRadius),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if ((state as CommandeStateLoaded)
                                  .commandeServices!
                                  .first
                                  .type ==
                              "dp")
                            Image.asset(
                              'assets/iconDP.png',
                              fit: BoxFit.fitWidth,
                              width: 48,
                            ),
                          if ((state as CommandeStateLoaded)
                                      .commandeServices!
                                      .length ==
                                  2 ||
                              (state as CommandeStateLoaded)
                                      .commandeServices!
                                      .first
                                      .type ==
                                  'mc')
                            Image.asset(
                              'assets/iconDR.png',
                              fit: BoxFit.fitWidth,
                              width: 48,
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        '${(state as CommandeStateLoaded).commandeServices!.length} services',
                        style: textStyleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          )),
        ],
      ),
    );
  }
}
