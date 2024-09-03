import 'package:contas_compartilhadas/core/enums/categoria_transacao.dart';
import 'package:contas_compartilhadas/core/enums/tipo_transacao.dart';

class Transacao {
  final String transacaoId;
  final String titulo;
  final double valor;
  final String usuarioId;
  final String grupoId;
  final DateTime data;
  final TipoTransacao tipo;
  final CategoriaTransacao categoria;

  Transacao({
    required this.transacaoId,
    required this.titulo,
    required this.valor,
    required this.usuarioId,
    required this.grupoId,
    required this.data,
    required this.categoria,
    required this.tipo,
  });
}
