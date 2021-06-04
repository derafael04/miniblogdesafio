import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/servicos/ServicosMicroBlog.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'ControladorUsuario.g.dart';

class ControladorUsuario = _ControladorUsuarioBase with _$ControladorUsuario;

abstract class _ControladorUsuarioBase with Store {
  Usuario usuarioLogado;
  ServicosMicroBlog service = GetIt.I.get<ServicosMicroBlog>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @observable
  ObservableList<Usuario> userLogado = ObservableList<Usuario>();

  void verificarSeTemUsuario(
      {Function() temUsuario, Function() naoTemUsuario}) {
    _prefs.then((db) {
      db.remove("user");
      var usuarioJson = db.getString("user");
      if (usuarioJson != null) {
        usuarioLogado = Usuario.fromJson(JsonCodec().decode(usuarioJson));
        temUsuario?.call();
      } else {
        naoTemUsuario?.call();
      }
    });
  }

  void cadastrarUsuario(Usuario usuarioCadastrar,
      {Function() sucesso, Function(String mensagem) erro}) {
    if (usuarioCadastrar.email?.isEmpty ?? true) {
      erro?.call("E-mail invalido");
    } else if (usuarioCadastrar.senha?.isEmpty ?? true) {
      erro?.call("Informe uma senha");
    } else if (usuarioCadastrar.nome?.isEmpty ?? true) {
      erro?.call("Informe seu nome");
    } else {
      service.cadastrarUsuario(usuarioCadastrar).then((usuario) {
        _prefs.then((db) {
          db.setString("user", JsonCodec().encode(usuario.sucesso.toJson()));
          usuarioLogado = usuario.sucesso;
          sucesso?.call();
        });
      }).catchError((onError) {
        erro?.call(onError.response.data["falha"]);
      });
    }
  }

  void logarUsuario(Usuario usuarioLogar,
      {Function() sucesso, Function(String mensagem) erro}) {
    if ((usuarioLogar.email?.isEmpty ?? true) ||
        (usuarioLogar.senha?.isEmpty ?? true)) {
      erro?.call("Usuário ou  senha invalido");
    } else {
      service
          .logarUsuario(usuarioLogar.email, usuarioLogar.senha)
          .then((usuario) {
        _prefs.then((db) {
          db.setString("user", JsonCodec().encode(usuario.sucesso.toJson()));
          usuarioLogado = usuario.sucesso;
          sucesso?.call();
        });
      }).catchError((onError) {
        erro?.call(onError.response.data["falha"]);
      });
    }
  }

  void editarUsuario(Usuario mUsuario,
      {Function() sucesso, Function(String mensagem) erro}) {
    service.editarUsuario(mUsuario).then((usuario) {
      _prefs.then((db) {
        db.remove('usuario');
        db.setString('usuario', JsonCodec().encode(usuario.sucesso.toJson()));
        usuarioLogado = usuario.sucesso;
        sucesso?.call();
      });
    }).catchError((onError) {
      erro?.call(onError.response.data["falha"]);
    });
  }

  void signOut({Function() deslogar}) {
    _prefs.then((db) {
      db.clear();
      usuarioLogado = null;
      deslogar?.call();
    });
  }
}
