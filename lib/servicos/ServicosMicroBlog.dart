import 'package:microblog/model/Postagem.dart';
import 'package:microblog/model/Usuario.dart';
import 'package:microblog/util/UtilRetornoUsuario.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'ServicosMicroBlog.g.dart';

@RestApi(baseUrl: "https://us-central1-meu-blog-curso.cloudfunctions.net")
abstract class ServicosMicroBlog {
  factory ServicosMicroBlog(Dio dio, {String baseUrl}) = _ServicosMicroBlog;

  //Usuario
  @POST("/usuarioKasqueta/cadastrarUsuario")
  Future<UtilRetornoUsuario> cadastrarUsuario(@Body() Usuario usuario);

  @POST("/usuarioKasqueta/editarUsuario")
  Future<UtilRetornoUsuario> editarUsuario(@Body() Usuario usuario);

  @GET("/usuarioKasqueta/logarUsuario")
  Future<UtilRetornoUsuario> logarUsuario(
      @Query("email") String email, @Query("senha") String senha);

  //Publicações
  @GET("/feedKasqueta/consultarPubliacoes")
  Future<UtilRetornoPublicacoes> consultarPublicacoes();

  @GET("/feedKasqueta/removerLike")
  Future<UtilRetornoPostagem> removerLike(
      @Query("id") String idPublicacao, @Query("idUsuario") String idUsuario);

  @POST("/feedKasqueta/darLike")
  Future<UtilRetornoPostagem> darLike(
      @Body() Usuario usuario, @Query("id") String idDaPublicacao);

  @GET("/feedKasqueta/excluirComentario")
  Future<UtilRetornoPostagem> excluirComentario(
      @Query("id") String idPost, @Query("idComentario") String idComentario);

  @POST("/feedKasqueta/comentarPost")
  Future<UtilRetornoPostagem> comentarPost(
      @Body() Comentario comentario, @Query("id") String id);

  @GET("/feedKasqueta/excluirPostagem")
  Future<String> excluirPostagem(@Query("id") String id);

  @POST("/feedKasqueta/manterPostagem")
  Future<UtilRetornoPostagem> manterPostagem(@Body() Postagem postagem);
}
