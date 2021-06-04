import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/screens/Login/Wigets/ButtonPadrao.dart';
import 'package:microblog/util/UtilDialog.dart';

class EditarAccount extends StatefulWidget {
  final Usuario usuarioEditar;
  const EditarAccount({Key key, this.usuarioEditar}) : super(key: key);

  @override
  _EditarAccountState createState() => _EditarAccountState();
}

class _EditarAccountState extends State<EditarAccount> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00acee),
        title: Text("Editar conta"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: TextEditingController(
                      text: _controladorUsuario.usuarioLogado.nome),
                  decoration: InputDecoration(
                      icon: Icon(Icons.people),
                      isDense: true,
                      labelText: 'Nome'),
                  onChanged: (text) {
                    _controladorUsuario.usuarioLogado.nome = text;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: TextEditingController(
                      text: _controladorUsuario.usuarioLogado.email),
                  decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      isDense: true,
                      labelText: 'E-mail'),
                  onChanged: (text) {
                    _controladorUsuario.usuarioLogado.email = text;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: TextEditingController(
                      text: _controladorUsuario.usuarioLogado.senha),
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      isDense: true,
                      labelText: 'Senha'),
                  obscureText: true,
                  onChanged: (text) {
                    _controladorUsuario.usuarioLogado.senha = text;
                  },
                ),
                SizedBox(height: 8),
                Observer(
                  builder: (_) {
                    return ButtonPadrao(
                        colorsButton: Color(0xff00acee),
                        colorsText: Colors.white,
                        value: "Salvar",
                        onTap: () {
                          _controladorUsuario.editarUsuario(
                              _controladorUsuario.usuarioLogado, sucesso: () {
                            Navigator.pop(context);
                          }, erro: (mensagem) {
                            UtilDialog.exibirDialog(context,
                                titulo: "Ops!", mensagem: mensagem);
                          });
                        });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
