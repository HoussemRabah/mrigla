import 'package:flutter/material.dart';
import 'package:mrigla/constants.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ServicesHeader(),
        SizedBox(
          height: 64.0,
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            ServicesSqaure(
              title: "diagnostic rapide",
              subtitle:
                  "Votre voiture est tombée en panne ? Faites un diagnostic rapide directement depuis votre smartphone pour découvrir le problème",
              image: "assets/iconDR.png",
            ),
            ServicesSqaure(
              title: "dépannage",
              subtitle:
                  "Demander une voiture de remorquage selon votre position",
              image: "assets/iconDP.png",
            ),
            ServicesSqaure(
              title: "demande de réparation",
              subtitle:
                  "Demandez un mécanicien et il viendra chez vous pour réparer votre voiture",
              image: "assets/iconMC.png",
            ),
            ServicesSqaure(
              title: "État de la route",
              subtitle:
                  "Vérifiez l'état de la route avant de vous déplacer pour éviter la circulation",
              image: "assets/iconRS.png",
            ),
          ],
        ),
      ],
    );
  }
}

class ServicesSqaure extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  const ServicesSqaure(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.5 - 8.0,
      decoration: BoxDecoration(color: colorWhite, borderRadius: borderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            image,
            fit: BoxFit.fitWidth,
            width: 48,
          ),
          Text(
            title,
            style: textStyleSimple.copyWith(color: colorBlack),
          ),
          Text(
            subtitle,
            style: textStyleSmall.copyWith(color: colorMain),
          ),
        ],
      ),
    );
  }
}

class ServicesHeader extends StatelessWidget {
  const ServicesHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      height: 225,
      width: double.infinity,
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
          color: colorMain, borderRadius: borderRadius, boxShadow: [shadows]),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Bienvenue à Marigla',
                style: textStyleBig.copyWith(color: colorWhite),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Ne craignez plus les pannes de voiture ! Profitez de nos services pour améliorer l'expérience d'être chauffeur en Algérie",
                style: textStyleSimple.copyWith(color: colorWhite),
              ),
            ],
          ),
          Positioned(
            top: 150,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/welcomeImage.png',
                fit: BoxFit.fitWidth,
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
