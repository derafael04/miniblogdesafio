// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ControladorPostagem.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControladorPostagem on _ControladorPostagemBase, Store {
  Computed<bool> _$habilitarPostarComputed;

  @override
  bool get habilitarPostar =>
      (_$habilitarPostarComputed ??= Computed<bool>(() => super.habilitarPostar,
              name: '_ControladorPostagemBase.habilitarPostar'))
          .value;

  final _$conteudoPublicacaoAtom =
      Atom(name: '_ControladorPostagemBase.conteudoPublicacao');

  @override
  String get conteudoPublicacao {
    _$conteudoPublicacaoAtom.reportRead();
    return super.conteudoPublicacao;
  }

  @override
  set conteudoPublicacao(String value) {
    _$conteudoPublicacaoAtom.reportWrite(value, super.conteudoPublicacao, () {
      super.conteudoPublicacao = value;
    });
  }

  final _$postagensAtom = Atom(name: '_ControladorPostagemBase.postagens');

  @override
  ObservableList<Postagem> get postagens {
    _$postagensAtom.reportRead();
    return super.postagens;
  }

  @override
  set postagens(ObservableList<Postagem> value) {
    _$postagensAtom.reportWrite(value, super.postagens, () {
      super.postagens = value;
    });
  }

  final _$comentariosAtom = Atom(name: '_ControladorPostagemBase.comentarios');

  @override
  ObservableList<Comentario> get comentarios {
    _$comentariosAtom.reportRead();
    return super.comentarios;
  }

  @override
  set comentarios(ObservableList<Comentario> value) {
    _$comentariosAtom.reportWrite(value, super.comentarios, () {
      super.comentarios = value;
    });
  }

  final _$statusConsultaFeedAtom =
      Atom(name: '_ControladorPostagemBase.statusConsultaFeed');

  @override
  StatusConsulta get statusConsultaFeed {
    _$statusConsultaFeedAtom.reportRead();
    return super.statusConsultaFeed;
  }

  @override
  set statusConsultaFeed(StatusConsulta value) {
    _$statusConsultaFeedAtom.reportWrite(value, super.statusConsultaFeed, () {
      super.statusConsultaFeed = value;
    });
  }

  @override
  String toString() {
    return '''
conteudoPublicacao: ${conteudoPublicacao},
postagens: ${postagens},
comentarios: ${comentarios},
statusConsultaFeed: ${statusConsultaFeed},
habilitarPostar: ${habilitarPostar}
    ''';
  }
}
