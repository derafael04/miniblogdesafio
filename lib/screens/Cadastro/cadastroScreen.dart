import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/screens/Login/Wigets/ButtonPadrao.dart';
import 'package:microblog/util/UtilDialog.dart';

class CadastroScreen extends StatefulWidget {
  CadastroScreen({Key key}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  Usuario _usuario = Usuario();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00acee),
        title: Text("Cadastro"),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Image.asset(
              'images/logo.png',
              width: 230,
              height: 230,
              fit: BoxFit.contain,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Nome Completo",
              ),
              style: GoogleFonts.rubik(color: Colors.black54, fontSize: 15),
              onChanged: (text) {
                _usuario.nome = text;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
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
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ButtonPadrao(
                colorsButton: Color(0xff00acee),
                colorsText: Colors.white,
                value: "Criar Conta",
                onTap: () {
                  _controladorUsuario.cadastrarUsuario(
                    _usuario,
                    sucesso: () {
                      Navigator.pushReplacementNamed(context, "/homeScreen");
                    },
                    erro: (mensagem) {
                      UtilDialog.exibirDialog(context,
                          titulo: "Ops!", mensagem: mensagem);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
