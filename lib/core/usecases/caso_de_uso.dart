import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CasoDeUso<Tipo, Parametros> {
  Future<Either<Falha, Tipo>> call(
    Parametros parametros,
  );
}

class SemParametros {}
