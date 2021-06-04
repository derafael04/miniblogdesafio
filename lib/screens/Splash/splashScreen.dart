import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      GetIt.I.get<ControladorUsuario>().verificarSeTemUsuario(temUsuario: () {
        Navigator.pushReplacementNamed(context, '/homeScreen');
      }, naoTemUsuario: () {
        Navigator.pushReplacementNamed(context, '/loginScreen');
      });
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff00acee),
        body: Center(child: Image.asset('images/splash.png')),
      ),
    );
  }
}
