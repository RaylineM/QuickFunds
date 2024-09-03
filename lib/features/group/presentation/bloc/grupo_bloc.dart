import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/adicionar_membro.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/criar_grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/obter_grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/obter_grupos.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/obter_membros.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/obter_transacoes_grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/remover_grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/remover_membro.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'grupo_event.dart';
part 'grupo_state.dart';

class GrupoBloc extends Bloc<GrupoEvent, GrupoState> {
  final CriarGrupo _criarGrupo;
  final RemoverGrupo _removerGrupo;
  final ObterGrupo _obterGrupo;
  final ObterGrupos _obterGrupos;
  final AdicionarMembro _adicionarMembro;
  final RemoverMembro _removerMembro;
  final ObterMembros _obterMembros;
  final ObterTransacoesGrupo _obterTransacoes;

  GrupoBloc({
    required CriarGrupo criarGrupo,
    required RemoverGrupo removerGrupo,
    required ObterGrupo obterGrupo,
    required ObterGrupos obterGrupos,
    required AdicionarMembro adicionarMembro,
    required RemoverMembro removerMembro,
    required ObterMembros obterMembros,
    required ObterTransacoesGrupo obterTransacoes,
  })  : _criarGrupo = criarGrupo,
        _removerGrupo = removerGrupo,
        _obterGrupo = obterGrupo,
        _obterGrupos = obterGrupos,
        _adicionarMembro = adicionarMembro,
        _removerMembro = removerMembro,
        _obterMembros = obterMembros,
        _obterTransacoes = obterTransacoes,
        super(GrupoEstadoInicial()) {
    on<GrupoEvent>((event, emit) => emit(GrupoEstadoCarregando()));
    on<EventoCriarGrupo>(_criar);
    on<EventoRemoverGrupo>(_remover);
    on<EventoObterGrupo>(_obter);
    on<EventoCarregarGrupos>(_obterTodosOsGrupos);
    on<EventoAdicionarMembro>(_adicionarMembroAoGrupo);
    on<EventoRemoverMembro>(_removerMembroDoGrupo);
    on<EventoObterMembros>(_obterMembrosDoGrupo);
    on<EventoObterTransacoes>(_obterTransacoesDoGrupo);
  }

  void _criar(
    EventoCriarGrupo event,
    Emitter<GrupoState> emit,
  ) async {
    final resultado = await _criarGrupo(
      ParametrosCriarGrupo(
        nome: event.nome,
        descricao: event.descricao,
        usuarioId: event.administradorId,
        membros: event.membrosId,
        transacoes: event.transacoesId,
      ),
    );
    resultado.fold(
      (falha) => emit(GrupoEstadoErro(falha.mensagem)),
      (grupo) => emit(GrupoEstadoCriadoComSucesso(grupo)),
    );
  }

  void _remover(
    EventoRemoverGrupo event,
    Emitter<GrupoState> emit,
  ) async {
    final resultado = await _removerGrupo(
      ParametrosRemoverGrupo(
        grupoId: event.grupoId,
      ),
    );
    resultado.fold(
      (falha) => emit(GrupoEstadoErro(falha.mensagem)),
      (_) => emit(GrupoEstadoRemovidoComSucesso()),
    );
  }

  void _obter(
    EventoObterGrupo event,
    Emitter<GrupoState> emit,
  ) async {
    final resultado = await _obterGrupo(
      ParametrosObterGrupo(
        grupoId: event.grupoId,
      ),
    );
    resultado.fold(
      (falha) => emit(GrupoEstadoErro(falha.mensagem)),
      (grupo) => emit(GrupoEstadoObtidoComSucesso(grupo)),
    );
  }

  void _obterTodosOsGrupos(
    EventoCarregarGrupos event,
    Emitter<GrupoState> emit,
  ) async {
    final resultado = await _obterGrupos(ParametrosObterGrupos(
      usuarioId: event.usuarioId,
    ));
    resultado.fold(
      (falha) => emit(GrupoEstadoErro(falha.mensagem)),
      (grupos) => emit(GrupoEstadoSucesso(grupos)),
    );
  }

  void _adicionarMembroAoGrupo(
    EventoAdicionarMembro event,
    Emitter<GrupoState> emit,
  ) async {
    final resultado = await _adicionarMembro(
      ParametrosAdicionarMembro(
        grupoId: event.grupoId,
        usuarioId: event.usuarioId,
      ),
    );
    resultado.fold(
      (falha) => emit(GrupoEstadoErro(falha.mensagem)),
      (_) => emit(GrupoEstadoMembroAdicionadoComSucesso()),
    );
  }

  void _removerMembroDoGrupo(
    EventoRemoverMembro event,
    Emitter<GrupoState> emit,
  ) async {
    final resultado = await _removerMembro(
      ParametrosRemoverMembro(
        grupoId: event.grupoId,
        usuarioId: event.usuarioId,
      ),
    );
    resultado.fold(
      (falha) => emit(GrupoEstadoErro(falha.mensagem)),
      (_) => emit(GrupoEstadoMembroRemovidoComSucesso()),
    );
  }

  void _obterMembrosDoGrupo(
    EventoObterMembros event,
    Emitter<GrupoState> emit,
  ) async {
    final resultado = await _obterMembros(
      ParametrosObterMembros(
        grupoId: event.grupoId,
      ),
    );
    resultado.fold(
      (falha) => emit(GrupoEstadoErro(falha.mensagem)),
      (membros) => emit(GrupoEstadoMembrosObtidosComSucesso(membros)),
    );
  }

  void _obterTransacoesDoGrupo(
    EventoObterTransacoes event,
    Emitter<GrupoState> emit,
  ) async {
    final resultado = await _obterTransacoes(
      ParametrosObterTransacoesGrupo(
        grupoId: event.grupoId,
      ),
    );
    resultado.fold(
      (falha) => emit(GrupoEstadoErro(falha.mensagem)),
      (transacoes) => emit(GrupoEstadoTransacoesObtidasComSucesso(transacoes)),
    );
  }
}
