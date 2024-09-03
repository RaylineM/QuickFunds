import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';

class GrupoModelo extends Grupo {
  GrupoModelo({
    required super.grupoId,
    required super.nome,
    required super.descricao,
    required super.administradorId,
    required super.membrosId,
    required super.transacoesId,
  });

  factory GrupoModelo.fromJson(Map<String, dynamic> json) {
    return GrupoModelo(
      grupoId: json['grupoId'],
      nome: json['nome'],
      descricao: json['descricao'],
      administradorId: json['administradorId'],
      membrosId: List<String>.from(json['membrosId']),
      transacoesId: List<String>.from(json['transacoesId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'grupoId': grupoId,
      'nome': nome,
      'descricao': descricao,
      'administradorId': administradorId,
      'membrosId': membrosId,
      'transacoesId': transacoesId,
    };
  }
}

