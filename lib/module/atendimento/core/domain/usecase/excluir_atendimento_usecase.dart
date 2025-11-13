import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/excluir_atendimento_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExcluirAtendimentoUsecase {
  final ExcluirAtendimentoRepository excluirAtendimentoRepository;
  ExcluirAtendimentoUsecase(this.excluirAtendimentoRepository);

  Future<void> excluir(int id) async {
    return excluirAtendimentoRepository.excluir(id);
  }
}
