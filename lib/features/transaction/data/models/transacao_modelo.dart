import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:contas_compartilhadas/core/enums/categoria_transacao.dart';
import 'package:contas_compartilhadas/core/enums/tipo_transacao.dart';

class TransacaoModelo extends Transacao {
  TransacaoModelo({
    required super.transacaoId,
    required super.titulo,
    required super.valor,
    required super.data,
    required super.usuarioId,
    required super.grupoId,
    required super.tipo,
    required super.categoria,
  });

  factory TransacaoModelo.fromJson(Map<String, dynamic> json) {
    return TransacaoModelo(
      transacaoId: json['transacaoId'],
      titulo: json['titulo'],
      valor: json['valor'],
      data: DateTime.parse(json['data']),
      usuarioId: json['usuarioId'],
      grupoId: json['grupoId'],
      tipo: TipoTransacao.values.firstWhere(
        (e) => e.toString() == json['tipo'],
        orElse: () => TipoTransacao.variavel,
      ),
      categoria: CategoriaTransacao.values.firstWhere(
        (e) => e.toString() == json['categoria'],
        orElse: () => CategoriaTransacao.outros,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transacaoId': transacaoId,
      'titulo': titulo,
      'valor': valor,
      'data': data.toIso8601String(),
      'usuarioId': usuarioId,
      'grupoId': grupoId,
      'tipo': tipo.toString(),
      'categoria': categoria.toString(),
    };
  }
}
