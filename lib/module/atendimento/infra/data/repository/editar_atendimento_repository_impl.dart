import 'package:atendimentos_flutter/database/database_helper.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/editar_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditarAtendimentoRepository)
class EditarAtendimentoRepositoryImpl implements EditarAtendimentoRepository {
  @override
  Future<Atendimento> editar(int id, Atendimento atendimento) async {
    return await DatabaseHelper.updateAtendimento(
      id,
      atendimento,
    ).then((value) => atendimento);
  }
}
