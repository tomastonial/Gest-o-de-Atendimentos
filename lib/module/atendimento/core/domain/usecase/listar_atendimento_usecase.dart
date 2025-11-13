import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/listar_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:injectable/injectable.dart';

@injectable
class ListarAtendimentoUsecase {
  final ListarAtendimentoRepository listarAtendimentoRepository;
  ListarAtendimentoUsecase(this.listarAtendimentoRepository);

  Future<List<Atendimento>> listarAtendimento() {
    return listarAtendimentoRepository.listarAtendimento();
  }
}
