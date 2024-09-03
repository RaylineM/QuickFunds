import 'package:contas_compartilhadas/core/enums/categoria_transacao.dart';
import 'package:contas_compartilhadas/core/enums/tipo_transacao.dart';
import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:contas_compartilhadas/features/transaction/domain/repos/repositorio_transacao.dart';
import 'package:fpdart/fpdart.dart';

class CriarTransacao implements CasoDeUso<Transacao, ParametrosCriarTransacao> {
  final RepositorioTransacao _repositorioTransacao;

  CriarTransacao(this._repositorioTransacao);

  @override
  Future<Either<Falha, Transacao>> call(
      ParametrosCriarTransacao parametros) async {
    return await _repositorioTransacao.criarTransacao(
      titulo: parametros.titulo,
      valor: parametros.valor,
      usuarioId: parametros.usuarioId,
      data: parametros.data,
      tipo: parametros.tipo,
      categoria: parametros.categoria,
      grupoId: parametros.grupoId,
    );
  }
}

class ParametrosCriarTransacao {
  final String usuarioId;
  final String grupoId;
  final String titulo;
  final double valor;
  final DateTime data;
  final TipoTransacao tipo;
  final CategoriaTransacao categoria;

  ParametrosCriarTransacao({
    required this.usuarioId,
    required this.grupoId,
    required this.titulo,
    required this.valor,
    required this.data,
    required this.tipo,
    required this.categoria,
  });
}
