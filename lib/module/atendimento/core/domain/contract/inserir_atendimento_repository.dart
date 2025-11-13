import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';

abstract class InserirAtendimentoRepository {
  Future<Atendimento> inserir(Atendimento atendimento);
}
