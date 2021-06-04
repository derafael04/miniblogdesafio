import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:microblog/controladores/ControladorPostagem.dart';
import 'package:microblog/screens/Home/Wigets/AppBotton.dart';
import 'package:microblog/screens/Home/Wigets/BottonBar.dart';
import 'package:microblog/util/StatusConsulta.dart';
import 'package:microblog/util/UtilDataHora.dart';
import 'package:microblog/util/UtilDialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ControladorPostagem _controladorPostagem = GetIt.I.get<ControladorPostagem>();
  BuildContext mMainContext;
  _consultarFeed() {
    _controladorPostagem.consultarFeed(
      sucesso: () {
        Navigator.pop(context);
        _refreshController.refreshCompleted();
      },
      carregando: () {
        UtilDialog.showLoading(context);
      },
      erro: (mensagem) {
        Navigator.pop(context);
        _refreshController.refreshFailed();
      },
    );
  }

  @override
  void initState() {
    mMainContext = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00acee),
        title: Text('Feed'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottonBar(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff00acee),
          child: Icon(Icons.post_add),
          onPressed: () {
            Navigator.pushNamed(context, "/novapostagem");
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(),
        onRefresh: _consultarFeed,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Observer(
                // ignore: missing_return
                builder: (_) {
                  switch (_controladorPostagem.statusConsultaFeed) {
                    case StatusConsulta.CARREGANDO:
                      return Text("Aguarde um momento...");
                      break;
                    case StatusConsulta.SUCESSO:
                      return ListView.builder(
                        primary: false,
                        itemBuilder: (context, index) {
                          var post = _controladorPostagem.postagens[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          post.criador.nome,
                                          style: GoogleFonts.rubik(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Visibility(
                                          visible: post.isCriador,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.grey[600],
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    UtilDialog.editarPub(
                                                        mMainContext, post);
                                                  }),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.grey[600],
                                                    size: 15,
                                                  ),
                                                  onPressed: () {
                                                    UtilDialog.excluirPub(
                                                        mMainContext, post);
                                                  })
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/publicacaoScreen");
                                      },
                                      child: Text(
                                        post.conteudo,
                                        style: GoogleFonts.rubik(
                                          color: Colors.black54,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            UtilDataHora.converteDateTime(
                                                post.dataDaPostagem),
                                            style: GoogleFonts.rubik(
                                              color: Colors.black54,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    AppBotton(postagem: post),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: _controladorPostagem.postagens.length,
                        shrinkWrap: true,
                      );
                      break;
                    case StatusConsulta.FALHA:
                      return Text("Ops! Não consegui carregar");
                      break;
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _consultarFeed();
  }
}
