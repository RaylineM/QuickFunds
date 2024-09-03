import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contas_compartilhadas/features/auth/presentation/bloc/auth_bloc.dart';

class PaginaRecuperacaoSenha extends StatefulWidget {
  const PaginaRecuperacaoSenha({super.key});

  @override
  State<PaginaRecuperacaoSenha> createState() => _PaginaRecuperacaoSenhaState();
}

class _PaginaRecuperacaoSenhaState extends State<PaginaRecuperacaoSenha> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 60),
              Text(
                'Recuperar Senha',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Digite seu email para enviar um link de recuperação de senha',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blueGrey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _formularioRecuperacaoSenha(),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthEstadoRecuperacaoSenhaComSucesso) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Link de recuperação enviado com sucesso!')),
                    );
                    Navigator.pop(context); // Voltar à tela anterior após sucesso
                  } else if (state is AuthEstadoErro) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.mensagem)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthEstadoRecuperacaoSenhaComSucesso) {
                    return const Text('Verifique seu email para o link de recuperação',
                        style: TextStyle(color: Colors.green, fontSize: 16.0));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formularioRecuperacaoSenha() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
             ElevatedButton(
  onPressed: _recuperarSenha,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey[700],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    minimumSize: Size(double.infinity, 50), 
  ),
  child: const Text(
    'Enviar Link de Recuperação',
    style: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
),
            ],
          ),
        ),
      ),
    );
  }

  void _recuperarSenha() async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            EventoRecuperarSenha(
              email: _emailController.text,
            ),
          );
    }
  }
}
