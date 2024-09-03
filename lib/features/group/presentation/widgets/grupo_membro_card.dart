import 'package:flutter/material.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';

class GrupoMembroCard extends StatelessWidget {
  final Usuario membro;

  const GrupoMembroCard({Key? key, required this.membro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(membro.nome),
        subtitle: Text(membro.email),
      ),
    );
  }
}
