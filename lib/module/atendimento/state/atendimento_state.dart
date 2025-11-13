import 'package:atendimentos_flutter/module/atendimento/core/domain/model/atendimento.dart';

abstract class AtendimentoState {}

class AtendimentoInitialState extends AtendimentoState {}

class AtendimentoLoadingState extends AtendimentoState {}

class AtendimentoLoadedState extends AtendimentoState {
  final List<Atendimento> atendimentos;
  AtendimentoLoadedState(this.atendimentos);
}

class AtendimentoFilteredState extends AtendimentoState {
  final List<Atendimento> atendimentos;
  AtendimentoFilteredState(this.atendimentos);
}
