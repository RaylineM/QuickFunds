import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/group/data/datasources/grupo_datasource.dart';
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';
import 'package:contas_compartilhadas/features/group/data/models/grupo_modelo.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class RepositorioGrupoImpl implements RepositorioGrupo {
  final GrupoDatasource _dataSource;

  RepositorioGrupoImpl(this._dataSource);

  @override
  Future<Either<Falha, Grupo>> criarGrupo({
    required String nome,
    required String descricao,
    required String usuarioId,
    required List<String> membros,
    required List<String> transacoes,
  }) async {

    membros.add(usuarioId);

    return _obterEntitade(() async => await _dataSource.criarGrupo(
          grupoModelo: GrupoModelo(
            grupoId: const Uuid().v4(),
            nome: nome,
            descricao: descricao,
            administradorId: usuarioId,
            membrosId: membros,
            transacoesId: transacoes,
          ),
        ));
  }

  @override
  Future<Either<Falha, void>> removerGrupo({required String grupoId}) async {
    try {
      await _dataSource.removerGrupo(grupoId: grupoId);
      return right(null);
    } catch (e) {
      return Left(Falha(e.toString()));
    }
  }

  @override
  Future<Either<Falha, Grupo>> obterGrupo({required String grupoId}) async {
    return _obterEntitade(
        () async => await _dataSource.obterGrupo(grupoId: grupoId));
  }

  @override
  Future<Either<Falha, List<Grupo>>> obterGrupos({
    required String usuarioId,
  }) async {
    try {
      final grupos = await _dataSource.obterGrupos(usuarioId: usuarioId);
      return Right(grupos);
    } catch (e) {
      return Left(Falha(e.toString()));
    }
  }

  @override
  Future<Either<Falha, void>> adicionarMembro({
    required String grupoId,
    required String usuarioId,
  }) async {
    try {
      await _dataSource.adicionarMembro(grupoId: grupoId, usuarioId: usuarioId);
      return right(null);
    } catch (e) {
      return Left(Falha(e.toString()));
    }
  }

  @override
  Future<Either<Falha, void>> removerMembro({
    required String grupoId,
    required String usuarioId,
  }) async {
    try {
      await _dataSource.removerMembro(grupoId: grupoId, usuarioId: usuarioId);
      return right(null);
    } catch (e) {
      return Left(Falha(e.toString()));
    }
  }

  @override
  Future<Either<Falha, List<Usuario>>> obterMembros(
      {required String grupoId}) async {
    try {
      final membros = await _dataSource.obterMembros(grupoId: grupoId);
      return Right(membros);
    } catch (e) {
      return Left(Falha(e.toString()));
    }
  }

  @override
  Future<Either<Falha, List<Transacao>>> obterTransacoes(
      {required String grupoId}) async {
    try {
      final transacoes = await _dataSource.obterTransacoes(grupoId: grupoId);
      return Right(transacoes);
    } catch (e) {
      return Left(Falha(e.toString()));
    }
  }

  Future<Either<Falha, Grupo>> _obterEntitade(
      Future<Grupo> Function() obterEntidade) async {
    try {
      final grupo = await obterEntidade();
      return Right(grupo);
    } catch (e) {
      return Left(Falha(e.toString()));
    }
  }
}
