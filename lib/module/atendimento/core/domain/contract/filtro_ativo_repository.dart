import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';

abstract class FiltroAtivoRepository {
  Future<List<Atendimento>> filtrarAtivos(bool ativo);
}
