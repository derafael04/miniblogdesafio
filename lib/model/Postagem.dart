import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/UtilDataHora.dart';

part 'Postagem.g.dart';

@JsonSerializable()
class Postagem {
  String id, conteudo;
  @JsonKey(fromJson: UtilDataHora.converteStringParaDate)
  DateTime dataDaPostagem;
  Usuario criador;
  List<Usuario> likes;
  List<Comentario> comentario;

  bool get isCriador =>
      GetIt.I.get<ControladorUsuario>().usuarioLogado.id.contains(criador.id);

  Postagem(
      {this.conteudo,
      this.criador,
      this.dataDaPostagem,
      this.id,
      this.likes,
      this.comentario});

  factory Postagem.fromJson(Map<String, dynamic> json) =>
      _$PostagemFromJson(json);
  Map<String, dynamic> toJson() => _$PostagemToJson(this);
}

@JsonSerializable()
class Comentario {
  String comentario, id;
  @JsonKey(fromJson: UtilDataHora.converteStringParaDate)
  DateTime dataDaPostagem;
  Usuario criador;
  Comentario({this.comentario, this.id, this.dataDaPostagem, this.criador});

  factory Comentario.fromJson(Map<String, dynamic> json) =>
      _$ComentarioFromJson(json);
  Map<String, dynamic> toJson() => _$ComentarioToJson(this);
}
