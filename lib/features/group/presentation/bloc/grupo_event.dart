part of 'grupo_bloc.dart';

@immutable
abstract class GrupoEvent {}

class EventoCarregarGrupos extends GrupoEvent {
  final String usuarioId;

  EventoCarregarGrupos({
    required this.usuarioId,
  });
}

class EventoCriarGrupo extends GrupoEvent {
  final String nome;
  final String descricao;
  final String administradorId;
  final List<String> membrosId;
  final List<String> transacoesId;

  EventoCriarGrupo({
    required this.nome,
    required this.descricao,
    required this.administradorId,
    required this.membrosId,
    required this.transacoesId,
  });
}

class EventoRemoverGrupo extends GrupoEvent {
  final String grupoId;

  EventoRemoverGrupo({
    required this.grupoId,
  });
}

class EventoAdicionarMembro extends GrupoEvent {
  final String grupoId;
  final String usuarioId;

  EventoAdicionarMembro({
    required this.grupoId,
    required this.usuarioId,
  });
}

class EventoRemoverMembro extends GrupoEvent {
  final String grupoId;
  final String usuarioId;

  EventoRemoverMembro({
    required this.grupoId,
    required this.usuarioId,
  });
}

class EventoObterGrupo extends GrupoEvent {
  final String usuarioId;
  final String grupoId;

  EventoObterGrupo({
    required this.usuarioId,
    required this.grupoId,
  });
}

class EventoObterMembros extends GrupoEvent {
  final String grupoId;

  EventoObterMembros({
    required this.grupoId,
  });
}

class EventoObterTransacoes extends GrupoEvent {
  final String grupoId;

  EventoObterTransacoes({
    required this.grupoId,
  });
}
