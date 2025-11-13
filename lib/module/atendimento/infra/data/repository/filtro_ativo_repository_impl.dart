import 'package:atendimentos_flutter/database/database_helper.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/filtro_ativo_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FiltroAtivoRepository)
class FiltroAtivoRepositoryImpl implements FiltroAtivoRepository {
  @override
  Future<List<Atendimento>> filtrarAtivos(bool ativo) async {
    final allAtendimentos = await DatabaseHelper.getAtendimentos();
    if (allAtendimentos == null) {
      return [];
    }
    return allAtendimentos
        .where((atendimento) => atendimento.ativo == ativo)
        .toList();
  }
}
