part of 'transacao_bloc.dart';

@immutable
abstract class TransacaoEvent {}

class EventoCarregarTransacoes extends TransacaoEvent {
  final String usuarioId;

  EventoCarregarTransacoes(this.usuarioId);
}

class EventoCriarTransacao extends TransacaoEvent {
  final String titulo;
  final double valor;
  final String usuarioId;
  final DateTime data;
  final TipoTransacao tipo;
  final CategoriaTransacao categoria;
  final String grupoId;

  EventoCriarTransacao({
    required this.titulo,
    required this.valor,
    required this.usuarioId,
    required this.data,
    required this.tipo,
    required this.categoria,
    required this.grupoId,
  });
}

class EventoRemoverTransacao extends TransacaoEvent {
  final String transacaoId;

  EventoRemoverTransacao(this.transacaoId);
}
