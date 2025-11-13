import 'package:atendimentos_flutter/database/database_helper.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/excluir_atendimento_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExcluirAtendimentoRepository)
class ExcluirAtendimentoRepositoryImpl implements ExcluirAtendimentoRepository {
  @override
  Future<void> excluir(int id) async {
    await DatabaseHelper.deleteAtendimento(id);
  }
}
