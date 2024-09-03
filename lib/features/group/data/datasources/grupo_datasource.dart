import 'package:contas_compartilhadas/features/auth/data/models/usuario.dart';
import 'package:contas_compartilhadas/features/group/data/models/grupo_modelo.dart';
import 'package:contas_compartilhadas/features/transaction/data/models/transacao_modelo.dart';

abstract interface class GrupoDatasource {
  Future<GrupoModelo> criarGrupo({
    required GrupoModelo grupoModelo,
  });

  Future<void> removerGrupo({
    required String grupoId,
  });

  Future<GrupoModelo> obterGrupo({
    required String grupoId,
  });

  Future<List<GrupoModelo>> obterGrupos({
    required String usuarioId,
  });

  Future<void> adicionarMembro({
    required String grupoId,
    required String usuarioId,
  });

  Future<void> removerMembro({
    required String grupoId,
    required String usuarioId,
  });

  Future<List<ModeloUsuario>> obterMembros({
    required String grupoId,
  });

  Future<List<TransacaoModelo>> obterTransacoes({
    required String grupoId,
  });
}
