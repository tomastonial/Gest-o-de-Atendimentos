// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/alterar_ativo_repository.dart'
    as _i562;
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/editar_atendimento_repository.dart'
    as _i1058;
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/excluir_atendimento_repository.dart'
    as _i166;
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/filtro_ativo_repository.dart'
    as _i487;
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/inserir_atendimento_repository.dart'
    as _i338;
import 'package:atendimentos_flutter/module/atendimento/core/domain/contract/listar_atendimento_repository.dart'
    as _i964;
import 'package:atendimentos_flutter/module/atendimento/core/domain/usecase/alterar_ativo_usecase.dart'
    as _i919;
import 'package:atendimentos_flutter/module/atendimento/core/domain/usecase/editar_atendimento_usecase.dart'
    as _i762;
import 'package:atendimentos_flutter/module/atendimento/core/domain/usecase/excluir_atendimento_usecase.dart'
    as _i978;
import 'package:atendimentos_flutter/module/atendimento/core/domain/usecase/filtro_ativo_usecase.dart'
    as _i399;
import 'package:atendimentos_flutter/module/atendimento/core/domain/usecase/inserir_atendimento_usecase.dart'
    as _i578;
import 'package:atendimentos_flutter/module/atendimento/core/domain/usecase/listar_atendimento_usecase.dart'
    as _i1015;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i919.AlterarAtivoUsecase>(
      () => _i919.AlterarAtivoUsecase(gh<_i562.AlterarAtivoRepository>()),
    );
    gh.factory<_i762.EditarAtendimentoUsecase>(
      () => _i762.EditarAtendimentoUsecase(
        gh<_i1058.EditarAtendimentoRepository>(),
      ),
    );
    gh.factory<_i978.ExcluirAtendimentoUsecase>(
      () => _i978.ExcluirAtendimentoUsecase(
        gh<_i166.ExcluirAtendimentoRepository>(),
      ),
    );
    gh.factory<_i399.FiltroAtivoUsecase>(
      () => _i399.FiltroAtivoUsecase(gh<_i487.FiltroAtivoRepository>()),
    );
    gh.factory<_i578.InserirAtendimentoUsecase>(
      () => _i578.InserirAtendimentoUsecase(
        gh<_i338.InserirAtendimentoRepository>(),
      ),
    );
    gh.factory<_i1015.ListarAtendimentoUsecase>(
      () => _i1015.ListarAtendimentoUsecase(
        gh<_i964.ListarAtendimentoRepository>(),
      ),
    );
    return this;
  }
}
