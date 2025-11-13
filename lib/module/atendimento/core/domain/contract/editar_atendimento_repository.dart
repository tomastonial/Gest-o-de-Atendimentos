import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';

abstract class EditarAtendimentoRepository {
  Future<Atendimento> editar(int id, Atendimento atendimento);
}
