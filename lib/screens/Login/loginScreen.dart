import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/screens/Login/Wigets/ButtonPadrao.dart';
import 'package:microblog/util/UtilDialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  Usuario _usuario = Usuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Image.asset('images/logo.png'),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: "E-mail",
            ),
            style: GoogleFonts.rubik(color: Colors.black54, fontSize: 15),
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) {
              _usuario.email = text;
            },
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              hintText: "Senha",
            ),
            style: GoogleFonts.rubik(color: Colors.black54, fontSize: 15),
            obscureText: true,
            onChanged: (text) {
              _usuario.senha = text;
            },
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
            height: 50,
            child: ButtonPadrao(
              colorsButton: Color(0xff00acee),
              colorsText: Colors.white,
              value: "Entrar",
              onTap: () {
                _controladorUsuario.logarUsuario(_usuario, sucesso: () {
                  Navigator.pushReplacementNamed(context, "/homeScreen");
                }, erro: (mensagem) {
                  UtilDialog.exibirDialog(context,
                      titulo: "Ops!", mensagem: mensagem);
                });
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ButtonPadrao(
            colorsButton: Colors.white,
            colorsText: Color(0xff00acee),
            value: "Cadastre-se",
            onTap: () {
              Navigator.pushNamed(context, "/cadastroScreen");
            },
          ),
        ],
      )),
    );
  }
}
