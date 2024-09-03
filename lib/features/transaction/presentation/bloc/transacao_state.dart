part of 'transacao_bloc.dart';

@immutable
abstract class TransacaoState {
  const TransacaoState();
}

class TransacaoEstadoInicial extends TransacaoState {}

class TransacaoEstadoCarregando extends TransacaoState {}

class TransacaoEstadoErro extends TransacaoState {
  final String mensagem;

  const TransacaoEstadoErro(this.mensagem);
}

class TransacaoEstadoSucesso extends TransacaoState {
  final List<Transacao> transacoes;

  const TransacaoEstadoSucesso(this.transacoes);
}

class TransacaoEstadoCriadaComSucesso extends TransacaoState {
  final Transacao transacao;

  const TransacaoEstadoCriadaComSucesso(this.transacao);
}

class TransacaoEstadoRemovidaComSucesso extends TransacaoState {}
