import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/filtro_ativo_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:injectable/injectable.dart';

@injectable
class FiltroAtivoUsecase {
  final FiltroAtivoRepository filtroAtivoRepository;
  FiltroAtivoUsecase(this.filtroAtivoRepository);

  Future<List<Atendimento>> filtrarAtivos(bool ativo) {
    return filtroAtivoRepository.filtrarAtivos(ativo);
  }
}
