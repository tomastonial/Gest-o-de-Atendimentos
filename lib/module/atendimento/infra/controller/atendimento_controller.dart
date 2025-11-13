import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/alterar_ativo_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/editar_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/excluir_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/filtro_ativo_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/inserir_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/listar_atendimento_repository.dart';
import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:atendimentos_flutter/module/atendimento/state/atendimento_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AtendimentoController extends Cubit<AtendimentoState> {
  final InserirAtendimentoRepository inserirAtendimentoRepository;
  final ListarAtendimentoRepository listarAtendimentoRepository;
  final EditarAtendimentoRepository editarAtendimentoRepository;
  final ExcluirAtendimentoRepository excluirAtendimentoRepository;
  final AlterarAtivoRepository alterarAtivoRepository;
  final FiltroAtivoRepository filtroAtivoRepository;

  AtendimentoController({
    required this.inserirAtendimentoRepository,
    required this.listarAtendimentoRepository,
    required this.editarAtendimentoRepository,
    required this.excluirAtendimentoRepository,
    required this.alterarAtivoRepository,
    required this.filtroAtivoRepository,
  }) : super(AtendimentoInitialState());

  Future<void> carregarAtendimentos() async {
    emit(AtendimentoLoadingState());
    final atendimentos = await listarAtendimentoRepository.listarAtendimento();
    emit(AtendimentoLoadedState(atendimentos));
  }

  Future<void> filtrarAtivos(bool ativos) async {
    emit(AtendimentoLoadingState());
    final atendimentosFiltrados = await filtroAtivoRepository.filtrarAtivos(
      ativos,
    );
    emit(AtendimentoFilteredState(atendimentosFiltrados));
  }

  Future<void> alterarAtivo(int id, bool ativo) async {
    await alterarAtivoRepository.alterarAtivo(id, ativo);
    await carregarAtendimentos();
  }

  Future<void> excluirAtendimento(int id) async {
    await excluirAtendimentoRepository.excluir(id);
    await carregarAtendimentos();
  }

  Future<void> inserirAtendimento(Atendimento atendimento) async {
    await inserirAtendimentoRepository.inserir(atendimento);
    await carregarAtendimentos();
  }

  Future<void> editarAtendimento(int id, Atendimento atendimento) async {
    await editarAtendimentoRepository.editar(id, atendimento);
    await carregarAtendimentos();
  }
}
