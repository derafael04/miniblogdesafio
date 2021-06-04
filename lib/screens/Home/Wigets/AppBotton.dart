import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorPostagem.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Postagem.dart';
import 'package:microblog/model/Usuario.dart';

class AppBotton extends StatefulWidget {
  final Postagem postagem;
  AppBotton({Key key, this.postagem}) : super(key: key);

  @override
  _AppBottonState createState() => _AppBottonState();
}

class _AppBottonState extends State<AppBotton> {
  ControladorPostagem _controladorPostagem = GetIt.I.get<ControladorPostagem>();
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Usuario curtidaDoUsuario = Usuario();
    if (widget.postagem.likes != null) {
      curtidaDoUsuario = widget.postagem.likes.firstWhere(
          (element) => element.id == _controladorUsuario.usuarioLogado.id,
          orElse: () => null);
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/comentarScreen");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Icon(
                      Icons.comment,
                      color: Colors.black54,
                    ),
                  ),
                ),
                widget.postagem.likes == null ||
                        widget.postagem.likes.length == 0
                    ? Row(
                        children: [
                          _iconCurtidaVazio(_controladorUsuario.usuarioLogado,
                              widget.postagem),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "  ",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      )
                    : curtidaDoUsuario == null ||
                            curtidaDoUsuario.id !=
                                _controladorUsuario.usuarioLogado.id
                        ? Row(
                            children: [
                              _iconCurtidaVazio(
                                  _controladorUsuario.usuarioLogado,
                                  widget.postagem),
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  widget.postagem.likes.length.toString(),
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 18),
                                ),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _controladorPostagem.darDislikePub(
                                      widget.postagem,
                                      _controladorUsuario.usuarioLogado);
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                    widget.postagem.likes.length.toString(),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 18)),
                              )
                            ],
                          ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _iconCurtidaVazio(Usuario usuario, Postagem postagem) {
    return GestureDetector(
      child: Icon(Icons.favorite_border),
      onTap: () {
        _controladorPostagem.darLikePub(usuario, postagem);
      },
    );
  }
}
