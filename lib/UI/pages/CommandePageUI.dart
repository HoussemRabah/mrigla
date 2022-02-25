import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mrigla/UI/widgets/containers.dart';
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
              else if (state is CommandeStateLoaded) if ((state).commandes ==
                  null)
                return Text('empty');
              else
                return Column(
                  children: [
                    CommandesHeader(state: state),
                    SizedBox(
                      height: 16.0,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.commandes!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: getCommandeContainerColor(
                                    state.commandes![index].stat),
                                borderRadius: borderRadius),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 200.0,
                                      child: Text(
                                        "bon de commande ${state.commandes![index].bon}",
                                        style: textStyleSimple.copyWith(
                                            color: getCommandeStatTextColor( state.commandes![index].stat)),
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            borderRadius: borderRadius,
                                            color: getCommandeStatColor(
                                                state.commandes![index].stat)),
                                        child: Text(
                                          getCommandeStat(
                                              state.commandes![index].stat),
                                          style: textStyleSimple.copyWith(
                                              color: getCommandeStatTextColor(
                                                  state
                                                      .commandes![index].stat)),
                                        )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/iconMN.png',
                                      width: 150,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              16.0 -
                                              150.0 -
                                              8.0 -
                                              16.0 -
                                              16.0 -
                                              20.0,
                                          child: Text(
                                            getCommandeStatSubText(
                                                state.commandes![index].stat),
                                            style: textStyleSmall.copyWith(
                                                color:
                                                    getCommandeStatSubTextColor(
                                                        state.commandes![index]
                                                            .stat)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    
                                    if (state.commandes![index].stat == "1" || 
                                    state.commandes![index].stat == "2" 
                                    || state.commandes![index].stat == "3")
                                    Sqaure(
                                        child: Center(
                                      child: Text(
                                        '${state.commandes![index].getTotalPrice()} DA',
                                        style: textStyleSmall,
                                      ),
                                    )),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    if (state.commandes![index].stat == "1" || 
                                    state.commandes![index].stat == "2" 
                                    || state.commandes![index].stat == "3")
                                    Sqaure(
                                        child: Center(
                                      child: Text(
                                        '${state.commandes![index].ordres.length} pieces',
                                        style: textStyleSmall,
                                      ),
                                    )),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    if (state.commandes![index].stat == "1")
                                      SqaureRed(
                                          child: Text(
                                        'anuller',
                                        style: textStyleSmall.copyWith(
                                            color: colorWhite),
                                      )),
                                    if (state.commandes![index].stat == "3" ||
                                        state.commandes![index].stat == "4" ||
                                        state.commandes![index].stat == "0")
                                      Sqaure(child: Icon(Ionicons.call)),
                                    if (state.commandes![index].stat == "4")
                                      Sqaure(child: Icon(Ionicons.map)),
                                    if (state.commandes![index].stat == "4")
                                      SqaureBlue(
                                          child: Text(
                                        "accusé de réception",
                                        textAlign: TextAlign.center,
                                        style: textStyleSmall.copyWith(
                                            color: colorWhite),
                                      )),
                                    if (state.commandes![index].stat == "0" ||
                                    state.commandes![index].stat == "5")
                                      Sqaure(
                                          child: Text(
                                        "ok",
                                        textAlign: TextAlign.center,
                                        style: textStyleSmall.copyWith(
                                            color: colorBlack),
                                      )),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
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
                        'assets/iconCR.png',
                        fit: BoxFit.fitWidth,
                        width: 48,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        (((state as CommandeStateLoaded).commandes!.length) > 1)
                            ? '${(state as CommandeStateLoaded).commandes!.length} piece'
                            : '${(state as CommandeStateLoaded).commandes!.length} pieces',
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
                  constraints: BoxConstraints.tightForFinite(),
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
                        ((state as CommandeStateLoaded)
                                    .commandeServices!
                                    .length >
                                1)
                            ? '${(state as CommandeStateLoaded).commandeServices!.length} service'
                            : '${(state as CommandeStateLoaded).commandeServices!.length} services',
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

String getCommandeStat(String stat) {
  return (stat == "1")
      ? "en attente"
      : (stat == "2")
          ? "en préparation"
          : (stat == "3")
              ? "en livraison"
              : (stat == "4")
                  ? "arrivée"
                  : (stat == "0")
                      ? "abandonner"
                      : "Échouer";
}

Color getCommandeStatColor(String stat) {
  switch (stat) {
    case "1":
      return colorBack;
    case "2":
      return colorForce;
    case "3":
      return colorForceBold;
    case "4":
      return colorMain;
    case "0":
      return colorRed;
    default:
      return colorRed;
  }
}

Color getCommandeStatTextColor(String stat) {
  switch (stat) {
    case "1":
      return colorBlack;
    case "2":
      return colorBlack;
    case "3":
      return colorBlack;
    case "4":
      return colorWhite;
    case "0":
      return colorWhite;
    default:
      return colorWhite;
  }
}

Color getCommandeContainerColor(String stat) {
  switch (stat) {
    case "1":
      return colorWhite;
    case "2":
      return colorWhite;
    case "3":
      return colorWhite;
    case "4":
      return colorMain;
    case "0":
      return colorRed;
    default:
      return colorRed;
  }
}

String getCommandeStatSubText(String stat) {
  switch (stat) {
    case "1":
      return "Votre commande est en cours de traitement, vous pouvez l'annuler modifier avant qu'il ne soit en phase de préparation";
    case "2":
      return "Votre commande est en cours de préparation pour livraison";
    case "3":
      return "Votre commande est en cours de livraison";
    case "4":
      return "Votre commande est arrivée à l'endroit convenu, veuillez confirmer la réception";
    case "0":
      return "Malheureusement votre commande a échoué, appelez pour en savoir plus";
    default:
      return "Vous avez annulé la commande";
  }
}

Color getCommandeStatSubTextColor(String stat) {
  switch (stat) {
    case "1":
      return colorMain;
    case "2":
      return colorMain;
    case "3":
      return colorMain;
    case "4":
      return colorWhite;
    case "0":
      return colorWhite;
    default:
      return colorWhite;
  }
}


