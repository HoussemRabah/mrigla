import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mrigla/Repository/commande_repo.dart';
import 'package:mrigla/UI/widgets/containers.dart';
import '../../constants.dart';
import '/../Bloc/auth/user_bloc.dart';
import '/../Bloc/commande/commande_bloc.dart';
import '/../UI/pages/HomeUI.dart';
import '/../UI/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommandePage extends StatefulWidget {
  const CommandePage({Key? key}) : super(key: key);

  @override
  State<CommandePage> createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
          else {
            context
                .read<CommandeBloc>()
                .add(CommandeEventInit((state as UserStateLoaded).user));
          }
          return BlocBuilder<CommandeBloc, CommandeState>(
            builder: (context, state) {
              if (state is CommandeStateLoading)
                return Loading();
              else if (state is CommandeStateLoaded) if ((state)
                          .commandes!
                          .length ==
                      0 &&
                  state.commandeServices!.length == 0)
                return EmptyView();
              else
                return Column(
                  children: [
                    if (state.commandes != null)
                      if (state.commandes!.length != 0)
                        CommandesHeader(state: state),
                    SizedBox(
                      height: 8.0,
                    ),
                    CommandesServiceList(
                      state: state,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    CommandesList(
                      state: state,
                    ),
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

class EmptyView extends StatelessWidget {
  const EmptyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Actuellement, vous n'avez pas demandé de service ou de pièces détachées",
              style: textStyleBig.copyWith(color: colorBlack),
              textAlign: TextAlign.center),
          Image.asset("assets/noItemImage.png",
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width * 0.8),
          Text(
              "Qu'attendez-vous? \nAchetez nos services et produits dès maintenant pour obtenir des points et gagner des cadeaux",
              style: textStyleSimple.copyWith(color: colorBlack),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class CommandesServiceList extends StatelessWidget {
  final CommandeStateLoaded state;
  const CommandesServiceList({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.commandeServices!.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: getCommandeServiceContainerColor(
                    state.commandeServices![index].stat),
                borderRadius: borderRadius),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          (state.commandeServices![index].type == "mc")
                              ? "Réquisition d'un mécanicien"
                              : "Réquisition d'un dépannage",
                          style: textStyleBig.copyWith(
                              color: getCommandeServiceStatTextColor(
                                  state.commandeServices![index].stat)),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            color: getCommandeServiceStatColor(
                                state.commandeServices![index].stat)),
                        child: Text(
                          getCommandeServiceStat(
                              state.commandeServices![index].stat),
                          overflow: TextOverflow.ellipsis,
                          style: textStyleSimple.copyWith(
                              color: getCommandeServiceStatTextColor(
                                  state.commandeServices![index].stat)),
                        )),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      (state.commandeServices![index].servicer == null)
                          ? state.commandeServices![index].servicer!.image
                          : "",
                      width: 150,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              16.0 -
                              150.0 -
                              8.0 -
                              16.0 -
                              16.0 -
                              30.0,
                          child: Text(
                            getCommandeServiceStatSubText(
                              state.commandeServices![index].stat,
                              state.commandeServices![index].servicerName,
                              state.commandeServices![index].type,
                            ),
                            style: textStyleSmall.copyWith(
                                color: getCommandeServiceStatSubTextColor(
                                    state.commandeServices![index].stat),
                                overflow: TextOverflow.clip),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (state.commandeServices![index].stat == "2")
                      Sqaure(
                          child: Center(
                        child: Text(
                          '50 min',
                          style: textStyleSmall,
                        ),
                      )),
                    if (state.commandeServices![index].stat == "1")
                      GestureDetector(
                        onTap: () {
                          context.read<CommandeBloc>().add(
                              CommandeEventServiceChangeStat(
                                  user: userBloc.user,
                                  commande: state.commandeServices![index],
                                  newStat: "0"));
                        },
                        child: SqaureRed(
                            child: Text(
                          'anuller',
                          style: textStyleSmall.copyWith(color: colorWhite),
                        )),
                      ),
                    if (state.commandeServices![index].stat == "2" ||
                        state.commandeServices![index].stat == "3" ||
                        state.commandeServices![index].stat == "0")
                      GestureDetector(
                        onTap: () {
                          call();
                        },
                        child: Sqaure(
                            child: Icon(
                          Ionicons.call,
                          color: colorMain,
                        )),
                      ),
                    if (state.commandeServices![index].stat == "3")
                      Sqaure(child: Icon(Ionicons.map, color: colorMain)),
                    if (state.commandeServices![index].stat == "3")
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CommandeBloc>()
                              .add(CommandeEventServiceDone(
                                user: userBloc.user,
                                commande: state.commandeServices![index],
                              ));
                        },
                        child: SqaureBlue(
                            child: Text(
                          "accusé de réception",
                          textAlign: TextAlign.center,
                          style: textStyleSmall.copyWith(color: colorWhite),
                        )),
                      ),
                    if (state.commandeServices![index].stat == "0" ||
                        state.commandeServices![index].stat == "4")
                      GestureDetector(
                        onTap: () {
                          context.read<CommandeBloc>().add(
                              CommandeEventServiceArchive(
                                  user: userBloc.user,
                                  commande: state.commandeServices![index]));
                        },
                        child: Sqaure(
                            child: Text(
                          "ok",
                          textAlign: TextAlign.center,
                          style: textStyleSmall.copyWith(color: colorBlack),
                        )),
                      ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class CommandesList extends StatelessWidget {
  final CommandeStateLoaded state;
  const CommandesList({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.commandes!.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: getCommandeContainerColor(state.commandes![index].stat),
                borderRadius: borderRadius),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          "bon de commande ${state.commandes![index].bon}",
                          style: textStyleBig.copyWith(
                              color: getCommandeStatTextColor(
                                  state.commandes![index].stat)),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            color: getCommandeStatColor(
                                state.commandes![index].stat)),
                        child: Text(
                          getCommandeStat(state.commandes![index].stat),
                          overflow: TextOverflow.ellipsis,
                          style: textStyleSimple.copyWith(
                              color: getCommandeStatTextColor(
                                  state.commandes![index].stat)),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              16.0 -
                              150.0 -
                              8.0 -
                              16.0 -
                              16.0 -
                              30.0,
                          child: Text(
                            getCommandeStatSubText(
                                state.commandes![index].stat),
                            style: textStyleSmall.copyWith(
                                color: getCommandeStatSubTextColor(
                                    state.commandes![index].stat),
                                overflow: TextOverflow.clip),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (state.commandes![index].stat == "1" ||
                        state.commandes![index].stat == "2" ||
                        state.commandes![index].stat == "3")
                      Sqaure(
                          child: Center(
                        child: Text(
                          '${state.commandes![index].getTotalPrice()} DA',
                          style: textStyleSmall,
                        ),
                      )),
                    if (state.commandes![index].stat == "1" ||
                        state.commandes![index].stat == "2" ||
                        state.commandes![index].stat == "3")
                      Sqaure(
                          child: Center(
                        child: Text(
                          '${state.commandes![index].ordres.length} pieces',
                          style: textStyleSmall,
                        ),
                      )),
                    if (state.commandes![index].stat == "1")
                      GestureDetector(
                        onTap: () {
                          context.read<CommandeBloc>().add(
                              CommandeEventChangeStat(
                                  commande: state.commandes![index],
                                  user: userBloc.user,
                                  newStat: '0'));
                        },
                        child: SqaureRed(
                            child: Text(
                          'anuller',
                          style: textStyleSmall.copyWith(color: colorWhite),
                        )),
                      ),
                    if (state.commandes![index].stat == "3" ||
                        state.commandes![index].stat == "4" ||
                        state.commandes![index].stat == "0")
                      GestureDetector(
                        onTap: () {
                          call();
                        },
                        child: Sqaure(
                            child: Icon(
                          Ionicons.call,
                          color: colorMain,
                        )),
                      ),
                    if (state.commandes![index].stat == "4")
                      GestureDetector(
                          onTap: () {
                            maps();
                          },
                          child: Sqaure(
                              child: Icon(Ionicons.map, color: colorMain))),
                    if (state.commandes![index].stat == "4")
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CommandeBloc>()
                              .add(CommandeEventCommandeDone(
                                commande: state.commandes![index],
                                user: userBloc.user,
                              ));
                        },
                        child: SqaureBlue(
                            child: Text(
                          "accusé de réception",
                          textAlign: TextAlign.center,
                          style: textStyleSmall.copyWith(color: colorWhite),
                        )),
                      ),
                    if (state.commandes![index].stat == "0" ||
                        state.commandes![index].stat == "5")
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CommandeBloc>()
                              .add(CommandeEventCommandeArchive(
                                commande: state.commandes![index],
                                user: userBloc.user,
                              ));
                        },
                        child: Sqaure(
                            child: Text(
                          "ok",
                          textAlign: TextAlign.center,
                          style: textStyleSmall.copyWith(color: colorBlack),
                        )),
                      ),
                  ],
                )
              ],
            ),
          );
        });
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
                if ((state as CommandeStateLoaded).commandeServices!.length > 0)
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
                                    .commandeServices !=
                                null)
                              if ((state as CommandeStateLoaded)
                                      .commandeServices!
                                      .length >
                                  0)
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
                                2)
                              if ((state as CommandeStateLoaded)
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
                      ? "Échouer"
                      : "abandonner";
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

// service

String getCommandeServiceStat(String stat) {
  return (stat == "1")
      ? "en attente"
      : (stat == "2")
          ? "en route"
          : (stat == "3")
              ? "Arrivée"
              : (stat == "0")
                  ? "Échouer"
                  : "abandonner";
}

Color getCommandeServiceStatColor(String stat) {
  switch (stat) {
    case "1":
      return colorBack;
    case "2":
      return colorForceBold;
    case "3":
      return colorMain;
    case "0":
      return colorRed;
    default:
      return colorRed;
  }
}

Color getCommandeServiceStatTextColor(String stat) {
  switch (stat) {
    case "1":
      return colorBlack;
    case "2":
      return colorBlack;
    case "3":
      return colorWhite;
    case "0":
      return colorWhite;
    default:
      return colorWhite;
  }
}

Color getCommandeServiceContainerColor(String stat) {
  switch (stat) {
    case "1":
      return colorWhite;
    case "2":
      return colorWhite;
    case "3":
      return colorMain;
    case "0":
      return colorRed;
    default:
      return colorRed;
  }
}

String getCommandeServiceStatSubText(String stat, String name, String type) {
  String job = (type == "mc") ? "Le mécanicien" : "le dépannage";
  switch (stat) {
    case "1":
      return "en cours de recherche";
    case "2":
      return "$job $name vient à vous";
    case "3":
      return "$job $name est à l'endroit convenu";
    case "0":
      return "Malheureusement, $job $name ne peut pas venir vous voir pour des raisons indépendantes de notre volonté";
    default:
      return "Vous avez annulé la commande";
  }
}

Color getCommandeServiceStatSubTextColor(String stat) {
  switch (stat) {
    case "1":
      return colorMain;
    case "2":
      return colorMain;
    case "3":
      return colorWhite;
    case "0":
      return colorWhite;
    default:
      return colorWhite;
  }
}
