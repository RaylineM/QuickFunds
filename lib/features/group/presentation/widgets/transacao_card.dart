import 'package:flutter/material.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';

class TransacaoCard extends StatelessWidget {
  final Transacao transacao;

  const TransacaoCard({Key? key, required this.transacao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        trailing: Text('R\$ ${transacao.valor.toStringAsFixed(2)}'),
      ),
    );
  }
}
