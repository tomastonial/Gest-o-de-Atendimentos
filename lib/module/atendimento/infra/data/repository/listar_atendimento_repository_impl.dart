import 'package:atendimentos_flutter/database/database_helper.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/listar_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ListarAtendimentoRepository)
class ListarAtendimentoRepositoryImpl implements ListarAtendimentoRepository {
  @override
  Future<List<Atendimento>> listarAtendimento() async {
    final atendimentos = await DatabaseHelper.getAtendimentos();
    return atendimentos ?? [];
  }
}
