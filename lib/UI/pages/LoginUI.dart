import 'package:flutter/material.dart';
import '/../UI/widgets/containers.dart';
import '/../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

int _tab = 0;
TextEditingController _prenom = TextEditingController();
TextEditingController _nom = TextEditingController();
TextEditingController _phone = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    _tab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // title header begin
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 0, 32.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenue à MRIGLA',
                    style: textStyleTitle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    (_tab == 0)
                        ? 'Pour profiter de nos services, connectez-vous avec votre compte'
                        : "Pour profiter de nos services, vous devez créer un nouveau compte",
                    style: textStyleSimple,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // title header end
            SizedBox(
              height: 8.0,
            ),
            // switcher tab begin
            Container(
              margin: EdgeInsets.fromLTRB(32.0, 0, 32.0, 0),
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _tab = 0;
                        setState(() {});
                      },
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color:
                                  (_tab == 0) ? colorMain : Colors.transparent),
                          child: Text(
                            "se connecter",
                            style: textStyleSimple.copyWith(
                                color: (_tab == 0) ? colorWhite : colorBlack),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        _tab = 1;
                        setState(() {});
                      },
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color:
                                  (_tab == 1) ? colorMain : Colors.transparent),
                          child: Text(
                            "créer un compte",
                            style: textStyleSimple.copyWith(
                                color: (_tab == 1) ? colorWhite : colorBlack),
                          )),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: colorForce,
              ),
            ),
            // switcher tab end
            if (_tab == 0) CenterBody(), // login
            if (_tab == 1) CenterBodyCreateAccount(), // signup
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 5.0,
                  width: MediaQuery.of(context).size.width * 0.2,
                  color: colorMain,
                ),
                Text(
                  "ou connectez-vous via",
                  style: textStyleSimple.copyWith(color: colorMain),
                ),
                Container(
                  height: 5.0,
                  width: MediaQuery.of(context).size.width * 0.2,
                  color: colorMain,
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Sqaure(
                  child: SvgPicture.asset('assets/googleIcon.svg'),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Sqaure(
                  child: SvgPicture.asset('assets/facebookIcon.svg'),
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}

class CenterBody extends StatefulWidget {
  const CenterBody({Key? key}) : super(key: key);

  @override
  _CenterBodyState createState() => _CenterBodyState();
}

class _CenterBodyState extends State<CenterBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            child: Image.asset(
              'assets/loginLogo.png',
              fit: BoxFit.scaleDown,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration:
                BoxDecoration(color: colorWhite, borderRadius: borderRadius),
            child: TextField(
              controller: _email,
              style: textStyleSimple,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "adresse email de l'utilisateur...",
                  hintStyle: textStyleSimple),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration:
                BoxDecoration(color: colorWhite, borderRadius: borderRadius),
            child: TextField(
              controller: _password,
              style: textStyleSimple,
              obscureText: true,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border: InputBorder.none,
                  hintText: "mot de passe...",
                  hintStyle: textStyleSimple),
            ),
          ),
          Container(
            child: Text(
              "mot de passe oublié?",
              style: textStyleSmall.copyWith(color: colorMain),
            ),
            alignment: Alignment.centerRight,
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: colorMain,
            ),
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'vas-y !',
              style: textStyleSimple.copyWith(color: colorWhite),
            ),
          )
        ],
      ),
    );
  }
}

class CenterBodyCreateAccount extends StatefulWidget {
  const CenterBodyCreateAccount({Key? key}) : super(key: key);

  @override
  _CenterBodyCreateAccountState createState() =>
      _CenterBodyCreateAccountState();
}

class _CenterBodyCreateAccountState extends State<CenterBodyCreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: colorWhite, borderRadius: borderRadius),
                  child: TextField(
                    controller: _nom,
                    style: textStyleSimple,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "nom",
                        hintStyle: textStyleSimple),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: colorWhite, borderRadius: borderRadius),
                  child: TextField(
                    controller: _prenom,
                    style: textStyleSimple,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "prenom",
                        hintStyle: textStyleSimple),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration:
                BoxDecoration(color: colorWhite, borderRadius: borderRadius),
            child: TextField(
              controller: _phone,
              style: textStyleSimple,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "numéro de téléphone",
                  hintStyle: textStyleSimple),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration:
                BoxDecoration(color: colorWhite, borderRadius: borderRadius),
            child: TextField(
              controller: _email,
              style: textStyleSimple,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "adresse email de l'utilisateur...",
                  hintStyle: textStyleSimple),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration:
                BoxDecoration(color: colorWhite, borderRadius: borderRadius),
            child: TextField(
              style: textStyleSimple,
              obscureText: true,
              controller: _password,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border: InputBorder.none,
                  hintText: "mot de passe...",
                  hintStyle: textStyleSimple),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: colorMain,
            ),
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'créer',
              style: textStyleSimple.copyWith(color: colorWhite),
            ),
          )
        ],
      ),
    );
  }
}
