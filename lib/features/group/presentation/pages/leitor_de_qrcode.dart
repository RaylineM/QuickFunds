import 'package:contas_compartilhadas/core/common/cubit/user/user_cubit.dart';
import 'package:contas_compartilhadas/features/group/presentation/bloc/grupo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeitorDeQrcode extends StatefulWidget {
  const LeitorDeQrcode({super.key});

  @override
  State<LeitorDeQrcode> createState() => _LeitorDeQrcodeState();
}

class _LeitorDeQrcodeState extends State<LeitorDeQrcode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? resultado;
  bool carregando = false;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GrupoBloc, GrupoState>(
      listener: (context, state) {
        if (state is GrupoEstadoMembroAdicionadoComSucesso) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Membro adicionado com sucesso!'),
            ),
          );
        } else if (state is GrupoEstadoErro) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.mensagem),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leitor de QRCode'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            if (resultado != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('resultadoado: ${resultado!.code}'),
              ),
            if (carregando)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        resultado = scanData;
        if (resultado != null) {
          final data = resultado!.code;
          if (data != null) {
            final parts = data.split('|');
            if (parts.length == 2) {
              final groupId = parts[0];
              final ownerId = parts[1];
              _addMemberToGroup(groupId, ownerId);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('QRCode inválido!'),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('QRCode inválido!'),
              ),
            );
          }
        }
      });
    });
  }

  void _addMemberToGroup(String groupId, String ownerId) {
    final userId = context.read<UsuarioCubit>().state.id;

    setState(() {
      carregando = true;
    });

    context.read<GrupoBloc>().add(EventoAdicionarMembro(
          usuarioId: userId,
          grupoId: groupId,
        ));
  }
}
