import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Postagem.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/servicos/ServicosMicroBlog.dart';
import 'package:microblog/util/StatusConsulta.dart';
import 'package:microblog/util/UtilRetornoUsuario.dart';
import 'package:mobx/mobx.dart';
part 'ControladorPostagem.g.dart';

class ControladorPostagem = _ControladorPostagemBase with _$ControladorPostagem;

abstract class _ControladorPostagemBase with Store {
  ServicosMicroBlog servico = GetIt.I.get<ServicosMicroBlog>();
  @observable
  String conteudoPublicacao = '';

  @observable
  ObservableList<Postagem> postagens = ObservableList<Postagem>();

  @observable
  ObservableList<Comentario> comentarios = ObservableList<Comentario>();

  @observable
  StatusConsulta statusConsultaFeed = StatusConsulta.CARREGANDO;

  @computed
  bool get habilitarPostar => conteudoPublicacao.isNotEmpty;

  void atualizarLista(
      Postagem postagem, UtilRetornoPostagem utilRetornoPostagem) {
    var index = postagens.indexWhere((post) => post.id == postagem.id);
    postagens.removeAt(index);
    postagens.insert(index, utilRetornoPostagem.sucesso);
  }

  void consultarFeed(
      {Function() sucesso,
      Function(String mensagem) erro,
      Function() carregando}) {
    carregando?.call();
    statusConsultaFeed = StatusConsulta.CARREGANDO;
    servico.consultarPublicacoes().then((responseTodasPublicacoes) {
      postagens.clear();
      postagens.addAll(responseTodasPublicacoes.sucesso);
      statusConsultaFeed = StatusConsulta.SUCESSO;
      sucesso?.call();
    }).catchError((onError) {
      statusConsultaFeed = StatusConsulta.FALHA;
      erro?.call(onError.response.data["falha"]);
    });
  }

  void publicarPostagem(Postagem postagem,
      {Function() sucesso,
      Function(String mensagem) erro,
      Function() carregando}) {
    if (postagem == null) {
      postagem = Postagem(
          conteudo: conteudoPublicacao,
          criador: GetIt.I.get<ControladorUsuario>().usuarioLogado);
    } else {
      postagem.conteudo = conteudoPublicacao;
    }
    carregando?.call();
    servico.manterPostagem(postagem).then((value) {
      atualizarLista(postagem, value);
      if (postagem.id == null)
        postagens.insert(0, value.sucesso);
      else {
        var index = postagens.indexWhere((post) => post.id == postagem.id);
        postagens.removeAt(index);
        postagens.insert(index, value.sucesso);
      }
      conteudoPublicacao = "";
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha"]);
    });
  }

  void excluirPostagem(Postagem postagem,
      {Function() sucesso,
      Function(String mensagem) erro,
      Function() carregando}) {
    carregando?.call();
    servico.excluirPostagem(postagem.id).then((value) {
      postagens.removeWhere((post) => post.id == postagem.id);
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha"]);
      statusConsultaFeed = StatusConsulta.FALHA;
    });
  }

  void comentarPub(Comentario comentario, Postagem postagem,
      {Function() sucesso,
      Function(String mensagem) erro,
      Function() carregando}) {
    comentario = Comentario(
      comentario: conteudoPublicacao,
      criador: GetIt.I.get<ControladorUsuario>().usuarioLogado,
    );
    carregando?.call();
    servico.comentarPost(comentario, postagem.id).then((value) {
      atualizarLista(postagem, value);
      conteudoPublicacao = "";
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data['falha']);
    });
  }

  void darLikePub(Usuario usuario, Postagem postagem,
      {Function() sucesso, Function(String mensagem) erro}) {
    servico.darLike(usuario, postagem.id).then((value) {
      atualizarLista(postagem, value);
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data['falha']);
    });
  }

  void darDislikePub(Postagem postagem, Usuario usuario,
      {Function() sucesso, Function(String mensagem) erro}) {
    servico.removerLike(postagem.id, usuario.id).then((value) {
      atualizarLista(postagem, value);
    }).catchError((onError) {
      erro?.call(onError.response.data['falha']);
    });
  }
}
