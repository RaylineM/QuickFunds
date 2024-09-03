import 'package:contas_compartilhadas/features/transaction/domain/usecases/criar_transacao.dart';
import 'package:contas_compartilhadas/features/transaction/domain/usecases/obter_transacoes.dart';
import 'package:contas_compartilhadas/features/transaction/domain/usecases/remover_transacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:contas_compartilhadas/core/enums/categoria_transacao.dart';
import 'package:contas_compartilhadas/core/enums/tipo_transacao.dart';

part 'transacao_event.dart';
part 'transacao_state.dart';

class TransacaoBloc extends Bloc<TransacaoEvent, TransacaoState> {
  final CriarTransacao _criarTransacao;
  final RemoverTransacao _removerTransacao;
  final ObterTransacoes _obterTransacoes;

  TransacaoBloc({
    required CriarTransacao criarTransacao,
    required RemoverTransacao removerTransacao,
    required ObterTransacoes obterTransacoes,
  })  : _criarTransacao = criarTransacao,
        _removerTransacao = removerTransacao,
        _obterTransacoes = obterTransacoes,
        super(TransacaoEstadoInicial()) {
    on<TransacaoEvent>((_, emit) => emit(TransacaoEstadoCarregando()));
    on<EventoCriarTransacao>(_criar);
    on<EventoRemoverTransacao>(_remover);
    on<EventoCarregarTransacoes>(_obter);
  }

  void _criar(
    EventoCriarTransacao event,
    Emitter<TransacaoState> emit,
  ) async {
    final resultado = await _criarTransacao(
      ParametrosCriarTransacao(
        usuarioId: event.usuarioId,
        grupoId: event.grupoId,
        titulo: event.titulo,
        valor: event.valor,
        data: event.data,
        tipo: event.tipo,
        categoria: event.categoria,
      ),
    );
    resultado.fold(
      (failure) => emit(TransacaoEstadoErro(failure.mensagem)),
      (transacao) => emit(TransacaoEstadoCriadaComSucesso(transacao)),
    );
  }

  void _remover(
    EventoRemoverTransacao event,
    Emitter<TransacaoState> emit,
  ) async {
    final resultado = await _removerTransacao(
      ParametrosRemoverTransacao(
        transacaoId: event.transacaoId,
      ),
    );

    resultado.fold(
      (failure) => emit(TransacaoEstadoErro(failure.mensagem)),
      (_) => emit(TransacaoEstadoRemovidaComSucesso()),
    );
  }

  void _obter(
    EventoCarregarTransacoes event,
    Emitter<TransacaoState> emit,
  ) async {
    final resultado = await _obterTransacoes(
      ParametrosObterTransacoes(
        usuarioId: event.usuarioId,
      ),
    );

    resultado.fold(
      (failure) => emit(TransacaoEstadoErro(failure.mensagem)),
      (transacoes) => emit(TransacaoEstadoSucesso(transacoes)),
    );
  }
}
