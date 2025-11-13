import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/alterar_ativo_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AlterarAtivoUsecase {
  final AlterarAtivoRepository alterarAtivoRepository;
  AlterarAtivoUsecase(this.alterarAtivoRepository);

  Future<void> alterarAtivo(int id, bool ativo) async {
    return alterarAtivoRepository.alterarAtivo(id, ativo);
  }
}
