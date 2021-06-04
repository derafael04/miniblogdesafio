// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Postagem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postagem _$PostagemFromJson(Map<String, dynamic> json) {
  return Postagem(
    conteudo: json['conteudo'] as String,
    criador: json['criador'] == null
        ? null
        : Usuario.fromJson(json['criador'] as Map<String, dynamic>),
    dataDaPostagem:
        UtilDataHora.converteStringParaDate(json['dataDaPostagem'] as String),
    id: json['id'] as String,
    likes: (json['likes'] as List)
        ?.map((e) =>
            e == null ? null : Usuario.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    comentario: (json['comentario'] as List)
        ?.map((e) =>
            e == null ? null : Comentario.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PostagemToJson(Postagem instance) => <String, dynamic>{
      'id': instance.id,
      'conteudo': instance.conteudo,
      'dataDaPostagem': instance.dataDaPostagem?.toIso8601String(),
      'criador': instance.criador,
      'likes': instance.likes,
      'comentario': instance.comentario,
    };

Comentario _$ComentarioFromJson(Map<String, dynamic> json) {
  return Comentario(
    comentario: json['comentario'] as String,
    id: json['id'] as String,
    dataDaPostagem:
        UtilDataHora.converteStringParaDate(json['dataDaPostagem'] as String),
    criador: json['criador'] == null
        ? null
        : Usuario.fromJson(json['criador'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ComentarioToJson(Comentario instance) =>
    <String, dynamic>{
      'comentario': instance.comentario,
      'id': instance.id,
      'dataDaPostagem': instance.dataDaPostagem?.toIso8601String(),
      'criador': instance.criador,
    };
