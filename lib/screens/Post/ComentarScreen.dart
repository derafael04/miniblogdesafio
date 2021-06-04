import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorPostagem.dart';
import 'package:microblog/model/Postagem.dart';
import 'package:microblog/screens/Login/Wigets/ButtonPadrao.dart';

class ComentarScreen extends StatefulWidget {
  const ComentarScreen({Key key}) : super(key: key);

  @override
  _ComentarScreenState createState() => _ComentarScreenState();
}

class _ComentarScreenState extends State<ComentarScreen> {
  ControladorPostagem _controladorPostagem = GetIt.I.get<ControladorPostagem>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comentar"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff00acee),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (text) {},
                        maxLines: 10,
                        decoration:
                            InputDecoration(hintText: "Comente sua resposta"),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 40,
                                child: ButtonPadrao(
                                  colorsButton: Colors.white,
                                  colorsText: Color(0xff00acee),
                                  value: "Cancelar",
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Container(
                                  width: 120,
                                  height: 40,
                                  child: Observer(
                                    builder: (_) {
                                      var habilitado = _controladorPostagem.habilitarPostar;
                                      return ButtonPadrao(
                                          colorsButton: Color(0xff00acee),
                                          colorsText: Colors.white,
                                          value: "Publicar",
                                          onTap: () {
                                            habilitado
                                           ? _controladorPostagem.comentarPub();
                                          }
                                          : null,
                                          );
                                    },
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
