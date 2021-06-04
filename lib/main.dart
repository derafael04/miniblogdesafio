import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorPostagem.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/screens/Account/AccountScreen.dart';
import 'package:microblog/screens/Account/EditarAccount.dart';
import 'package:microblog/screens/Cadastro/cadastroScreen.dart';
import 'package:microblog/screens/Explorar/SearchScreen.dart';
import 'package:microblog/screens/Home/homeScreen.dart';
import 'package:microblog/screens/Login/loginScreen.dart';
import 'package:microblog/screens/Notificacoes/Notificacoes.dart';
import 'package:microblog/screens/Post/ComentarScreen.dart';
import 'package:microblog/screens/Post/postScreen.dart';
import 'package:microblog/screens/Splash/splashScreen.dart';
import 'package:microblog/servicos/ServicosMicroBlog.dart';

final getIt = GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton(ServicosMicroBlog(Dio()));
  getIt.registerSingleton(ControladorUsuario());
  getIt.registerSingleton(ControladorPostagem());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color(0xff00acee),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (_) => SplashScreen(),
        "/loginScreen": (_) => LoginScreen(),
        "/homeScreen": (_) => HomeScreen(),
        "/cadastroScreen": (_) => CadastroScreen(),
        "/novapostagem": (_) => PostScreen(),
        "/notificacoes": (_) => NotificacoesScreen(),
        "/search": (_) => SearchScreen(),
        "/accountScreen": (_) => AccountScreen(),
        "/editarAccount": (_) => EditarAccount(),
        "/comentarScreen": (_) => ComentarScreen(),
      },
    );
  }
}
