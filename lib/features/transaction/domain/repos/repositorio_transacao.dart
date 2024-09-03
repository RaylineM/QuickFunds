import 'package:contas_compartilhadas/core/enums/categoria_transacao.dart';
import 'package:contas_compartilhadas/core/enums/tipo_transacao.dart';
import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RepositorioTransacao {
  Future<Either<Falha, Transacao>> criarTransacao({
    required String titulo,
    required double valor,
    required String usuarioId,
    required DateTime data,
    required TipoTransacao tipo,
    required CategoriaTransacao categoria,
    required String grupoId,
  });

  Future<Either<Falha, void>> removerTransacao({
    required String transacaoId,
  });

  Future<Either<Falha, List<Transacao>>> obterTransacoes({
    required String usuarioId,
  });
}
