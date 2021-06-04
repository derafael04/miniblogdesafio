import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00acee),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff00acee),
        title: Text("Minha Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _controladorUsuario.usuarioLogado.nome,
                            style: GoogleFonts.rubik(
                                fontSize: 20,
                                color: Color(0xff00acee),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            _controladorUsuario.usuarioLogado.email,
                            style: GoogleFonts.rubik(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/editarAccount");
                        },
                        child: Text("Editar"),
                        textColor: Color(0xff00acee),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Sair",
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    color: Color(0xff00acee),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  _controladorUsuario.signOut(deslogar: () {
                    Navigator.pushReplacementNamed(context, "/loginScreen");
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
