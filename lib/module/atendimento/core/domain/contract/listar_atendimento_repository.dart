import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';

abstract class ListarAtendimentoRepository {
  Future<List<Atendimento>> listarAtendimento();
}
