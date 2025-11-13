import 'package:atendimentos_flutter/database/database_helper.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/inserir_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: InserirAtendimentoRepository)
class InserirAtendimentoRepositoryImpl implements InserirAtendimentoRepository {
  @override
  Future<Atendimento> inserir(Atendimento atendimento) async {
    return atendimento..id = await DatabaseHelper.addAtendimento(atendimento);
  }
}
