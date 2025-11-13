import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/editar_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditarAtendimentoUsecase {
  final EditarAtendimentoRepository editarAtendimentoRepository;
  EditarAtendimentoUsecase(this.editarAtendimentoRepository);

  Future<Atendimento> editar(int id, Atendimento atendimento) {
    return editarAtendimentoRepository.editar(id, atendimento);
  }
}
