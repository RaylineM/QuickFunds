import 'package:contas_compartilhadas/core/common/cubit/user/user_cubit.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/login_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/logout_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/registrar_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/usuario_atual.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/recuperar_senha_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/atualizar_renda_fixa_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/atualizar_tipo_conta_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegistrarUsuario _registrarUsuario;
  final LoginUsuarios _loginUsuarios;
  final UsuarioAtual _usuarioAtual;
  final UsuarioLogout _usuarioLogout;
  final RecuperarSenhaUsuario _recuperarSenhaUsuario;
  final AtualizarRendaFixaUsuario _atualizarRendaFixaUsuario;
  final AtualizarTipoContaUsuario _atualizarTipoContaUsuario;
  final UsuarioCubit _usuarioCubit;

  AuthBloc({
    required RegistrarUsuario registrarUsuario,
    required LoginUsuarios loginUsuarios,
    required UsuarioAtual usuarioAtual,
    required UsuarioLogout usuarioLogout,
    required RecuperarSenhaUsuario recuperarSenhaUsuario,
    required AtualizarRendaFixaUsuario atualizarRendaFixaUsuario,
    required AtualizarTipoContaUsuario atualizarTipoContaUsuario,
    required UsuarioCubit usuarioCubit,
  })  : _registrarUsuario = registrarUsuario,
        _loginUsuarios = loginUsuarios,
        _usuarioAtual = usuarioAtual,
        _usuarioLogout = usuarioLogout,
        _recuperarSenhaUsuario = recuperarSenhaUsuario,
        _atualizarRendaFixaUsuario = atualizarRendaFixaUsuario,
        _atualizarTipoContaUsuario = atualizarTipoContaUsuario,
        _usuarioCubit = usuarioCubit,
        super(AuthEstadoInicial()) {
    on<EventoLogin>(_login);
    on<EventoRegistrar>(_registrar);
    on<EventoUsuarioLogado>(_isLoggedIn);
    on<EventoUsuarioLogout>(_logout);
    on<EventoRecuperarSenha>(_passwordRecover);
    on<EventoAtualizarRendaFixa>(_updateFixedIncome);
    on<EventoAtualizarTipoConta>(_updateAccountType);
  }

  void _isLoggedIn(
    EventoUsuarioLogado event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _usuarioAtual(SemParametros());
    response.fold(
      (falha) => emit(AuthEstadoErro(falha.mensagem)),
      (usuario) => _emitAuthSuccessState(usuario, emit),
    );
  }

  void _login(
    EventoLogin event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final response = await _loginUsuarios(
        ParametrosLogin(
          email: event.email,
          password: event.senha,
        ),
      );
      response.fold(
        (falha) => emit(AuthEstadoErro(falha.mensagem)),
        (usuario) => _emitAuthSuccessState(usuario, emit),
      );
    } catch (e) {
      emit(AuthEstadoErro(e.toString()));
    }
  }

  void _registrar(
    EventoRegistrar event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final response = await _registrarUsuario(
        ParametrosRegistrar(
          email: event.email,
          nome: event.nome,
          password: event.senha,
        ),
      );
      response.fold(
        (falha) => emit(AuthEstadoErro(falha.mensagem)),
        (usuario) => _emitAuthSuccessState(usuario, emit),
      );
    } catch (e) {
      emit(AuthEstadoErro(e.toString()));
    }
  }

  void _logout(
    EventoUsuarioLogout event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _usuarioLogout(SemParametros());
    response.fold(
      (falha) => emit(AuthEstadoErro(falha.mensagem)),
      (_) {
        _usuarioCubit.atualizar(null);
        emit(AuthEstadoInicial());
      },
    );
  }

  void _passwordRecover(
    EventoRecuperarSenha event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final response = await _recuperarSenhaUsuario(
        ParametrosRecuperarSenha(email: event.email),
      );
      response.fold(
        (falha) => emit(AuthEstadoErro(falha.mensagem)),
        (_) => emit(AuthEstadoRecuperacaoSenhaComSucesso()),
      );
    } catch (e) {
      emit(AuthEstadoErro(e.toString()));
    }
  }

  void _updateFixedIncome(
    EventoAtualizarRendaFixa event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final response = await _atualizarRendaFixaUsuario(
        ParametrosAtualizarRendaFixaUsuario(
          usuarioId: event.usuarioId,
          novaRendaFixa: event.novaRendaFixa,
        ),
      );
      response.fold(
        (falha) => emit(AuthEstadoErro(falha.mensagem)),
        (usuario) => emit(AuthEstadoAtualizacaoRendaFixaComSucesso(usuario)),
      );
    } catch (e) {
      emit(AuthEstadoErro(e.toString()));
    }
  }

  void _updateAccountType(
    EventoAtualizarTipoConta event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final response = await _atualizarTipoContaUsuario(
        ParamentrosAtualizarTipoContaUsuario(
          usuarioId: event.usuarioId,
          prime: event.novoTipoConta,
        ),
      );
      response.fold(
        (falha) => emit(AuthEstadoErro(falha.mensagem)),
        (usuario) => emit(AuthEstadoAtualizacaoTipoContaComSucesso(usuario)),
      );
    } catch (e) {
      emit(AuthEstadoErro(e.toString()));
    }
  }

  void _emitAuthSuccessState(
    Usuario usuario,
    Emitter<AuthState> emit,
  ) {
    if (state is! AuthEstadoSucesso ||
        (state as AuthEstadoSucesso).usuario != usuario) {
      _usuarioCubit.atualizar(usuario);
      emit(AuthEstadoSucesso(usuario));
    }
  }
}
