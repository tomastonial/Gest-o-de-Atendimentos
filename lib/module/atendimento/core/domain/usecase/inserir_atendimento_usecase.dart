import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/inserir_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:injectable/injectable.dart';

@injectable
class InserirAtendimentoUsecase {
  final InserirAtendimentoRepository inserirAtendimentoRepository;
  InserirAtendimentoUsecase(this.inserirAtendimentoRepository);

  Future<Atendimento> inserir(Atendimento atendimento) async {
    return inserirAtendimentoRepository.inserir(atendimento);
  }
}
