import 'package:firebase_auth/firebase_auth.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';

class ModeloUsuario extends Usuario {
  final bool prime;

  ModeloUsuario({
    required super.id,
    required super.email,
    required super.nome,
    this.prime = true,  
  });

  factory ModeloUsuario.fromJson(Map<String, dynamic> json) {
    return ModeloUsuario(
      id: json['id'],
      email: json['email'],
      nome: json['nome'],
      prime: json['prime'] ?? true,  
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nome': nome,
      'prime': prime,
    };
  }

  factory ModeloUsuario.fromFirebaseUsuario(User user) {

    
    return ModeloUsuario(
      id: user.uid,
      email: user.email ?? '',
      nome: user.displayName ?? '',
      prime: true,

    );
  }

  ModeloUsuario copyWith({
    String? id,
    String? email,
    String? nome,
    bool? prime,
  }) {
    return ModeloUsuario(
      id: id ?? this.id,
      email: email ?? this.email,
      nome: nome ?? this.nome,
      prime: prime ?? this.prime,
    );
  }

  static ModeloUsuario fromEntity(Usuario usuario) {
    return ModeloUsuario(
      id: usuario.id,
      email: usuario.email,
      nome: usuario.nome,
    );
  }


}