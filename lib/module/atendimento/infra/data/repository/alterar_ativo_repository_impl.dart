import 'package:atendimentos_flutter/database/database_helper.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/alterar_ativo_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AlterarAtivoRepository)
class AlterarAtivoRepositoryImpl implements AlterarAtivoRepository {
  @override
  Future<void> alterarAtivo(int id, bool ativo) async {
    await DatabaseHelper.alterarAtivo(id, ativo);
  }
}
