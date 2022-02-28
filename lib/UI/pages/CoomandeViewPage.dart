import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mrigla/Bloc/commande/commande_bloc.dart';
import 'package:mrigla/UI/pages/HomeUI.dart';
import 'package:mrigla/UI/widgets/containers.dart';
import 'package:mrigla/UI/widgets/dialogues.dart';
import 'package:mrigla/UI/widgets/loading.dart';
import 'package:mrigla/modules/commandeModule.dart';

import '../../constants.dart';
import 'CommandePageUI.dart';

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
                    statuContainer(
                      widget: widget,
                      state: state,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    InfoContainer(index: widget.index, state: state),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          borderRadius: borderRadius, color: colorWhite),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          infoLine(
                              title: "Date d'arrivée prévue",
                              info: (state.commandes![widget.index].livraison !=
                                      null)
                                  ? "${state.commandes![widget.index].livraison!.date}"
                                  : "..."),
                          infoLine(
                              title: "lieu d'arrivée",
                              info: (state.commandes![widget.index].livraison !=
                                      null)
                                  ? "${state.commandes![widget.index].livraison!.meta}"
                                  : "..."),
                          GestureDetector(
                              onTap: () {
                                maps();
                              },
                              child: Sqaure(
                                  child: Icon(Ionicons.map, color: colorMain))),
                        ],
                      ),
                    ),
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

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    Key? key,
    required this.index,
    required this.state,
  }) : super(key: key);

  final int index;
  final CommandeStateLoaded state;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: colorWhite, borderRadius: borderRadius),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          infoLine(title: "bon de commande", info: state.commandes![index].bon),
          infoLine(title: "date", info: state.commandes![index].date),
          infoLine(
              title: "prix net",
              info: "${state.commandes![index].getTotalPrice()} DA"),
          infoLine(
              title: "prix livraison",
              info: (state.commandes![index].livraison != null)
                  ? "${state.commandes![index].livraison!.prix} DA"
                  : "..."),
          infoLine(
              title: "prix total",
              info: (state.commandes![index].livraison != null)
                  ? "${state.commandes![index].livraison!.prix + state.commandes![index].getTotalPrice()} DA"
                  : "..."),
        ],
      ),
    );
  }
}

class infoLine extends StatelessWidget {
  const infoLine({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Text(
            title,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.start,
            style: textStyleSimple.copyWith(color: colorBlack),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            info,
            textAlign: TextAlign.end,
            overflow: TextOverflow.clip,
            style: textStyleSimple.copyWith(color: colorBlack),
          ),
        ),
      ],
    );
  }
}

class statuContainer extends StatelessWidget {
  const statuContainer({
    Key? key,
    required this.widget,
    required this.state,
  }) : super(key: key);

  final CommandePageView widget;
  final CommandeStateLoaded state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorWhite, borderRadius: borderRadius),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "statut",
              style: textStyleSimple,
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color:
                      getCommandeStatColor(state.commandes![widget.index].stat),
                ),
                child: Text(
                  getCommandeStat(state.commandes![widget.index].stat),
                  style: textStyleBig.copyWith(
                    color: getCommandeStatTextColor(
                        state.commandes![widget.index].stat),
                  ),
                )),
            SizedBox(
              height: 8.0,
            ),
            Text(
              getCommandeStatSubText(state.commandes![widget.index].stat),
              style: textStyleSmall.copyWith(
                color: colorMain,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (state.commandes![widget.index].stat == "1")
                  GestureDetector(
                    onTap: () {
                      annulerCommandeDialogue(context, () {
                        context.read<CommandeBloc>().add(
                            CommandeEventChangeStat(
                                commande: state.commandes![widget.index],
                                user: userBloc.user,
                                newStat: '0'));
                      });
                    },
                    child: SqaureRed(
                        child: Text(
                      'annuler',
                      style: textStyleSmall.copyWith(color: colorWhite),
                    )),
                  ),
                if (state.commandes![widget.index].stat == "3" ||
                    state.commandes![widget.index].stat == "4" ||
                    state.commandes![widget.index].stat == "0")
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
                if (state.commandes![widget.index].stat == "4")
                  GestureDetector(
                      onTap: () {
                        maps();
                      },
                      child:
                          Sqaure(child: Icon(Ionicons.map, color: colorMain))),
                if (state.commandes![widget.index].stat == "4")
                  GestureDetector(
                    onTap: () {
                      OkCommandeDialogue(context, () {
                        context
                            .read<CommandeBloc>()
                            .add(CommandeEventCommandeDone(
                              commande: state.commandes![widget.index],
                              user: userBloc.user,
                            ));
                      });
                    },
                    child: SqaureBlue(
                        child: Text(
                      "accusé de réception",
                      textAlign: TextAlign.center,
                      style: textStyleSmall.copyWith(color: colorWhite),
                    )),
                  ),
                if (state.commandes![widget.index].stat == "0" ||
                    state.commandes![widget.index].stat == "5")
                  GestureDetector(
                    onTap: () {
                      context
                          .read<CommandeBloc>()
                          .add(CommandeEventCommandeArchive(
                            commande: state.commandes![widget.index],
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
          ]),
    );
  }
}
