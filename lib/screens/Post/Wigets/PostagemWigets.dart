import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorPostagem.dart';
import 'package:microblog/model/Postagem.dart';
import 'package:microblog/screens/Login/Wigets/ButtonPadrao.dart';
import 'package:microblog/util/UtilDialog.dart';

class PostagemWigets extends StatefulWidget {
  final Postagem postagemEditar;
  final Function() sucesso;
  const PostagemWigets({Key key, this.postagemEditar, this.sucesso})
      : super(key: key);

  @override
  _PostagemWigetsState createState() => _PostagemWigetsState();
}

class _PostagemWigetsState extends State<PostagemWigets> {
  ControladorPostagem _controladorPostagem = GetIt.I.get<ControladorPostagem>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                _controladorPostagem.conteudoPublicacao = text;
              },
              controller: TextEditingController(
                  text: widget.postagemEditar?.conteudo ??
                      _controladorPostagem.conteudoPublicacao),
              maxLines: 10,
              decoration: InputDecoration(hintText: "O que está acontecendo?"),
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
                    Observer(
                      builder: (_) {
                        var habilitado = _controladorPostagem.habilitarPostar;
                        return Container(
                          width: 120,
                          height: 40,
                          child: ButtonPadrao(
                            colorsButton: Color(0xff00acee),
                            colorsText: Colors.white,
                            value: widget.postagemEditar != null
                                ? "Editar"
                                : "Publicar",
                            onTap: habilitado
                                ? () {
                                    _controladorPostagem.publicarPostagem(
                                        widget.postagemEditar, sucesso: () {
                                      Navigator.pushNamed(
                                          context, "/homeScreen");
                                      setState(() {});
                                      widget.sucesso();
                                    }, erro: (mensagem) {
                                      Navigator.pop(context);
                                      UtilDialog.exibirDialog(context,
                                          titulo: "Ops!", mensagem: mensagem);
                                    }, carregando: () {
                                      UtilDialog.showLoading(context);
                                    });
                                  }
                                : null,
                          ),
                        );
                      },
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
