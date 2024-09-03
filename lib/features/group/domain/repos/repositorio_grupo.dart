import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RepositorioGrupo {
  Future<Either<Falha, Grupo>> criarGrupo({
    required String nome,
    required String descricao,
    required String usuarioId,
    required List<String> membros,
    required List<String> transacoes,
  });
  
  Future<Either<Falha, void>> removerGrupo({
    required String grupoId,
  });

  Future<Either<Falha, Grupo>> obterGrupo({
    required String grupoId,
  });

  Future<Either<Falha, List<Grupo>>> obterGrupos({
    required String usuarioId,
  });

  Future<Either<Falha, void>> adicionarMembro({
    required String grupoId,
    required String usuarioId,
  });

  Future<Either<Falha, void>> removerMembro({
    required String grupoId,
    required String usuarioId,
  });

  Future<Either<Falha, List<Transacao>>> obterTransacoes({
    required String grupoId,
  });

  Future<Either<Falha, List<Usuario>>> obterMembros({
    required String grupoId,
  });
}
