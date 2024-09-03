import 'package:contas_compartilhadas/core/errors/excecoes.dart';
import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/features/transaction/data/datasources/transacao_datasource.dart';
import 'package:contas_compartilhadas/features/transaction/data/models/transacao_modelo.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:contas_compartilhadas/features/transaction/domain/repos/repositorio_transacao.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';
import 'package:contas_compartilhadas/core/enums/categoria_transacao.dart';
import 'package:contas_compartilhadas/core/enums/tipo_transacao.dart';

class RepositorioTransacaoImpl implements RepositorioTransacao {
  final TransacaoDataSource _dataSource;
  
  RepositorioTransacaoImpl(this._dataSource);

  @override
  Future<Either<Falha, Transacao>> criarTransacao({
    required String titulo,
    required double valor,
    required String usuarioId,
    required DateTime data,
    required TipoTransacao tipo,
    required CategoriaTransacao categoria,
    required String grupoId,
  }) async {
    return _obterEntitade(() async => await _dataSource.criarTransacao(
          transacaoModelo: TransacaoModelo(
            transacaoId: const Uuid().v4(),
            titulo: titulo,
            valor: valor,
            data: data,
            usuarioId: usuarioId,
            grupoId: grupoId,
            tipo: tipo,
            categoria: categoria,
          ),
        ));
  }

  @override
  Future<Either<Falha, void>> removerTransacao({
    required String transacaoId,
  }) async {
    try {
      await _dataSource.removerTransacao(transacaoId: transacaoId);
      return right(null);
    } on ExcecoesDoServidor catch (e) {
      return left(Falha(e.mensagem));
    }
  }

  @override
  Future<Either<Falha, List<Transacao>>> obterTransacoes({
    required String usuarioId,
  }) async {
    try {
      final transacoes =
          await _dataSource.obterTransacoes(usuarioId: usuarioId);
      return right(transacoes);
    } on ExcecoesDoServidor catch (e) {
      return left(Falha(e.mensagem));
    }
  }

  Future<Either<Falha, Transacao>> _obterEntitade(
    Future<Transacao> Function() obterTransacao,
  ) async {
    try {
      final transacao = await obterTransacao();
      return Right(transacao);
    } on ExcecoesDoServidor catch (e) {
      return left(Falha(e.mensagem));
    }
  }
}
