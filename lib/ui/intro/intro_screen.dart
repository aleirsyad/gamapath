import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamapath/repositories/user_repository.dart';
import 'package:gamapath/ui/auth/login/login_screen.dart';
import 'package:gamapath/styles/theme.dart' as Style;
import 'package:gamapath/ui/auth/register/register_screen.dart';

class IntroScreen extends StatefulWidget{
  final UserRepository userRepository;

  IntroScreen({Key? key, required this.userRepository})
      :super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState(userRepository);
}

class _IntroScreenState extends State<IntroScreen>{
  final UserRepository userRepository;
  _IntroScreenState(this.userRepository);

  @override
  Widget build(BuildContext context){
    final loginButton = Container(
      height: 56,
      decoration: BoxDecoration(
        color: Style.Colors.mainColor,
        borderRadius: BorderRadius.circular(14.0),
      ),child: Material(
      color: Colors.transparent,
      child: RaisedButton(
        color: Style.Colors.mainColor,
        disabledColor: Style.Colors.textWhiteGrey,
        disabledTextColor: Style.Colors.textGrey,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(14.0)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen(userRepository: userRepository)));
        },
        child: Center(
          child: Text(
            "LOGIN",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600)
                .copyWith(
                color:
                Style.Colors.colorWhite),
          ),
        ),
      ),
    ),);
    final registerButton = Container(
        height: 56,
        decoration: BoxDecoration(
          color: Style.Colors.mainColor,
          borderRadius: BorderRadius.circular(14.0),
        ),child: Material(
      color: Colors.transparent,
      child: RaisedButton(
        color: Style.Colors.mainColor,
        disabledColor: Style.Colors.textWhiteGrey,
        disabledTextColor: Style.Colors.textGrey,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(14.0)),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => RegisterScreen(userRepository: userRepository)));
        },
        child: Center(
          child: Text(
            "SIGN UP",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600)
                .copyWith(
                color:
                Style.Colors.colorWhite),
          ),
        ),
      ),
    ),);

    return Scaffold(
      backgroundColor: Colors.white,
      body:
          Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GAMAPATH',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ).copyWith(color: Style.Colors.secondBlack),
                ),
                Text(
                  'Aplikasi pendamping praktikum Patologi Anatomik FK-KMK UGM\nHibah Akademik Pengembangan Mata Kuliah Berbasis Teknologi Informasi 2021',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ).copyWith(color: Style.Colors.secondBlack),
                ),
                SizedBox(
                  height: 32,
                ),
                loginButton,
                SizedBox(
                  height: 16,
                ),
                registerButton
              ],
            ),
          ]),
        ),
    );
  }
}