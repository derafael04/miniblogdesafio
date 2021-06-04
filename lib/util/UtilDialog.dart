import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorPostagem.dart';
import 'package:microblog/model/Postagem.dart';
import 'package:microblog/screens/Login/Wigets/ButtonPadrao.dart';
import 'package:microblog/screens/Post/Wigets/PostagemWigets.dart';

class UtilDialog {
  static void exibirDialog(BuildContext context,
      {String titulo, String mensagem}) {
    SnackBar(
      content: Text("$titulo" + "$mensagem"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 4),
    );
  }

  static void showLoading(BuildContext context,
      {String titulo, String mensagem}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff00acee)),
            ),
          ),
        );
      },
    );
  }

  static void excluirPub(BuildContext mainContext, Postagem postagem) {
    ControladorPostagem _controladorPostagem =
        GetIt.I.get<ControladorPostagem>();
    showDialog(
      context: mainContext,
      builder: (context) {
        return Center(
          child: Card(
            margin: EdgeInsets.all(24),
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Atenção, deseja excluir?",
                        style: TextStyle(fontSize: 16, color: Colors.black87)),
                    Divider(),
                    Text(
                      "${postagem.criador.nome}",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "${postagem.conteudo}",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 30,
                      child: Row(
                        children: [
                          Expanded(
                            child: ButtonPadrao(
                              colorsButton: Colors.white,
                              colorsText: Colors.black87,
                              value: "Cancelar",
                              onTap: () {
                                Navigator.pop(mainContext);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: ButtonPadrao(
                              colorsButton: Color(0xff00acee),
                              colorsText: Colors.white,
                              value: "Sim Excluir",
                              onTap: () {
                                _controladorPostagem.excluirPostagem(postagem,
                                    carregando: () {
                                  Navigator.pop(mainContext);
                                  showLoading(mainContext);
                                }, sucesso: () {
                                  Navigator.pop(mainContext);
                                  exibirDialog(mainContext,
                                      titulo: "Sucesso!",
                                      mensagem: "A postagem foi excluida");
                                }, erro: (mensagem) {
                                  Navigator.pop(mainContext);
                                  exibirDialog(mainContext,
                                      titulo: "Ops!", mensagem: mensagem);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  static void editarPub(BuildContext mainContext, Postagem postagem) {
    ControladorPostagem _controladorPostagem =
        GetIt.I.get<ControladorPostagem>();
    showDialog(
      context: mainContext,
      builder: (context) {
        return Center(
          child: Card(
            margin: EdgeInsets.all(24),
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Atenção, Voce está editando",
                        style: TextStyle(fontSize: 16, color: Colors.black87)),
                    Divider(),
                    PostagemWigets(
                      postagemEditar: postagem,
                      sucesso: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
