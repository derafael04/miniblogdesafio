// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ControladorUsuario.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControladorUsuario on _ControladorUsuarioBase, Store {
  final _$userLogadoAtom = Atom(name: '_ControladorUsuarioBase.userLogado');

  @override
  ObservableList<Usuario> get userLogado {
    _$userLogadoAtom.reportRead();
    return super.userLogado;
  }

  @override
  set userLogado(ObservableList<Usuario> value) {
    _$userLogadoAtom.reportWrite(value, super.userLogado, () {
      super.userLogado = value;
    });
  }

  @override
  String toString() {
    return '''
userLogado: ${userLogado}
    ''';
  }
}
