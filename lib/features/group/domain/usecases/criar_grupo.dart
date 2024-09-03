import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';
import 'package:fpdart/fpdart.dart';

class CriarGrupo implements CasoDeUso<Grupo, ParametrosCriarGrupo> {
  final RepositorioGrupo _repositorioGrupo;

  CriarGrupo(this._repositorioGrupo);

  @override
  Future<Either<Falha, Grupo>> call(ParametrosCriarGrupo parametros) async {
    return _repositorioGrupo.criarGrupo(
      nome: parametros.nome,
      descricao: parametros.descricao,
      usuarioId: parametros.usuarioId,
      membros: parametros.membros,
      transacoes: parametros.transacoes,
    );
  }
}

class ParametrosCriarGrupo {
  final String nome;
  final String descricao;
  final String usuarioId;
  final List<String> membros;
  final List<String> transacoes;

  ParametrosCriarGrupo(
      {required this.nome,
      required this.descricao,
      required this.usuarioId,
      required this.membros,
      required this.transacoes});
}
