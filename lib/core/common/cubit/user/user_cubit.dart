import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  UsuarioCubit() : super(UsuarioStateInicial());

  void atualizar(Usuario? usuario) {
    if (usuario != null) {
      emit(UsuarioStateLogado(usuario)); 
    } else {
      emit(UsuarioStateInicial());
    }
  }
}
